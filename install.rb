#!/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/bin/ruby
# Most of this was copied from the homebrew install script
require 'open3'

SSH_DIR = "#{ENV["HOME"]}/.ssh".freeze
PROJECT_DIR = "#{ENV["HOME"]}/Projects".freeze
CONFIG_DIR = "#{ENV["HOME"]}/Projects/dotfiles".freeze

module Tty
  module_function

  def blue
    bold 34
  end

  def red
    bold 31
  end

  def reset
    escape 0
  end

  def bold(n = 39)
    escape "1;#{n}"
  end

  def underline
    escape "4;39"
  end

  def escape(n)
    "\033[#{n}m" if STDOUT.tty?
  end
end

class Array
  def shell_s
    cp = dup
    first = cp.shift
    cp.map { |arg| arg.gsub " ", "\\ " }.unshift(first).join(" ")
  end
end

def ohai(*args)
  puts "#{Tty.blue}==>#{Tty.bold} #{args.shell_s}#{Tty.reset}"
end

def warn(warning)
  puts "#{Tty.red}Warning#{Tty.reset}: #{warning.chomp}"
end

def system(*args)
  abort "Failed during: #{args.shell_s}" unless Kernel.system(*args)
end

def capture_system(*args)
  stdout, stderr, status = Open3.capture3(*args)
  abort "Failed during: #{args.shell_s}" unless status
  stdout
end

def sudo(*args)
  args.unshift("-A") unless ENV["SUDO_ASKPASS"].nil?
  ohai "/usr/bin/sudo", *args
  system "/usr/bin/sudo", *args
end

def provision_sshkey(id,name=nil)
  result = capture_system 'lpass', 'show', id
  hash = {}
  result.scan(/^(?<=\n)([A-Z ]+):\s+(.*?)(?=\n[A-Z ]+:|\Z)/mi) do |match|
    hash[match[0]] = match[1]
  end
  name = "#{name}_rsa" if name
  pri = File.join(SSH_DIR,name || 'id_rsa')
  pub = File.join(SSH_DIR,(name || 'id_rsa') + '.pub')
  File.open(pri, 'w') { |file| file.write(hash["Private Key"] + "\n") }
  File.open(pub, 'w') { |file| file.write(hash["Public Key"] + "\n") }
  File.chmod(0644,pub)
  File.chmod(0600,pri)
  system 'ssh-add',"-qK", File.join(Dir.home,'.ssh',name || 'id_rsa')
end

def getc
  system "/bin/stty raw -echo"
  if STDIN.respond_to?(:getbyte)
    STDIN.getbyte
  else
    STDIN.getc
  end
ensure
  system "/bin/stty -raw echo"
end

class Version
  include Comparable
  attr_reader :parts

  def initialize(str)
    @parts = str.split(".").map { |p| p.to_i }
  end

  def <=>(other)
    parts <=> self.class.new(other).parts
  end
end

def macos_version
  @macos_version ||= Version.new(`/usr/bin/sw_vers -productVersion`.chomp[/10\.\d+/])
end

def should_install_homebrew?
  !File.exist?("/usr/local/bin/brew")
end

def git
  @git ||= if ENV["GIT"] && File.executable?(ENV["GIT"])
    ENV["GIT"]
  elsif Kernel.system "/usr/bin/which -s git"
    "git"
  else
    exe = `xcrun -find git 2>/dev/null`.chomp
    exe if $? && $?.success? && !exe.empty? && File.executable?(exe)
  end

  return unless @git
  # Github only supports HTTPS fetches on 1.7.10 or later:
  # https://help.github.com/articles/https-cloning-errors
  `#{@git} --version` =~ /git version (\d\.\d+\.\d+)/
  return if $1.nil?
  return if Version.new($1) < "1.7.10"

  @git
end

def mkdir_p(mode,dir)
  if Dir.exists?(dir)
    if File.stat(dir).to_s()[3..5] != "700"
      ohai "Fixing permissions on #{dir}"
      abort "Cound't chmod #{dir}" unless File.chmod(0700,dir)
    end
    #sudo "/usr/sbin/chown", ENV["USER"], dir if chown?(dir)
    #sudo "/usr/bin/chgrp", "staff", dir if chgrp?(dir)
  else
    ohai "Creating #{dir}"
    about "Couldn't create #{dir}" unless Dir.mkdir(dir, 0700)
  end
end

# Invalidate sudo timestamp before exiting (if it wasn't active before).
Kernel.system "/usr/bin/sudo -n -v 2>/dev/null"
at_exit { Kernel.system "/usr/bin/sudo", "-k" } unless $?.success?

# The block form of Dir.chdir fails later if Dir.CWD doesn't exist which I
# guess is fair enough. Also sudo prints a warning message for no good reason
Dir.chdir "/usr"

####################################################################### script
#abort "Already installed nothing to do" if Dir.exists?( File.join(Dir.home,"Projects","dotfiles") ) 
abort "This is the macOS installer, not Linux!" if RUBY_PLATFORM.to_s.downcase.include?("linux")
abort "Mac OS X too old" if macos_version < "10.5"
abort "Don't run this as root!" if Process.uid.zero?
abort <<-EOABORT unless `dsmemberutil checkmembership -U "#{ENV["USER"]}" -G admin`.include? "user is a member"
This installer requires the user #{ENV["USER"]} to be an Administrator.
EOABORT

if should_install_homebrew?
  abort "Can't proceed! Homebrew not installed." unless Kernel.system("/usr/bin/ruby","-e",`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`)
end

system 'brew', 'update'
system 'brew', 'install', 'lastpass-cli', '--with-pinentry'

mkdir_p(0700,SSH_DIR)
mkdir_p(0700,PROJECT_DIR)

config = File.join(ENV["HOME"], ".ssh", "config")
unless File.exists?(config)
  File.open(config, 'w') do |f|
    f.write("Host *\n")
    f.write("\tAddKeysToAgent yes\n")
    f.write("\tUseKeychain yes\n")
    f.write("\tIdentityFile ~/.ssh/id_rsa\n")
  end
end
File.chmod(0600, config)

ohai "Login to LastPass to Retrieve SSH Keys"

print "LastPass Login Email: "
email = gets.chomp
abort "Must provide login to continue!" unless email != ""
system 'lpass', 'login', email


list = capture_system 'lpass','ls','SysConfig'
found = false
secure_env = ""
list.scan(/^SysConfig\/(.*?) \[id: (\d+)\]$/m) do |match|
  (name,id) = match
  if name == "Primary SSH Key"
    provision_sshkey(id)
  elsif name == "Secure Env Vars"
    result = capture_system 'lpass', 'show', id
    if result =~ /Notes:\W+(.*?)\Z/m
      File.open(File.join(CONFIG_DIR,'zsh','secure_env'),'w') do |f|
	f.write($1)
      end
    end
  elsif name =~ /\ASSH Key \((.*?)\)\Z/
    provision_sshkey(id,$1)
    #puts "SSH KEY: #{$1} #{id}"
  end
  found = true
  #puts "Found: #{match}" 
end
abort "No secure notes found in list SysConfig group on LastPass" unless found

unless Dir.exists?( File.join(Dir.home,"Projects","dotfiles") ) 
  Dir.chdir(PROJECT_DIR) do
    system 'git', 'clone', 'git@bitbucket.org:sdhall/dotfiles.git'
  end
end

#install Oh My ZSH
system "sh", "-c", `curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh`
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search




system "/usr/bin/env", "zsh", "#{CONFIG_DIR}/brew.sh"
system "/usr/bin/env", "zsh", "#{CONFIG_DIR}/brew-apps.sh"
system "/usr/bin/env", "zsh", "#{CONFIG_DIR}/VSCode/install.sh"
system "/usr/bin/env", "zsh", "#{CONFIG_DIR}/macos.sh"
system "/usr/bin/env", "zsh", "#{CONFIG_DIR}/symlinks.sh"

ohai "Installation successful!"
puts

# Use the shell's audible bell.
print "\a"
