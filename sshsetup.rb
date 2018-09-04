#!/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/bin/ruby
# Most of this was copied from the homebrew install script
require 'open3'

HOMEBREW_PREFIX = "/usr/local".freeze
HOMEBREW_REPOSITORY = "/usr/local/Homebrew".freeze

SSH_DIR = "#{ENV["HOME"]}/.ssh".freeze

HOMEBREW_OLD_CACHE = "/Library/Caches/Homebrew".freeze

DOTFILE_REPO = "https://github.com/Homebrew/brew".freeze
LPASS_CLI_REPO = "https://github.com/Homebrew/homebrew-core".freeze

# TODO: bump version when new macOS is released
MACOS_LATEST_SUPPORTED = "10.13".freeze
# TODO: bump version when new macOS is released
MACOS_OLDEST_SUPPORTED = "10.11".freeze


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
  pri = File.join(SSH_DIR,name || 'id_rsa')
  pub = File.join(SSH_DIR,(name || 'id_rsa') + '.pub')
  File.open(pri, 'w') { |file| file.write(hash["Private Key"] + "\n") }
  File.open(pub, 'w') { |file| file.write(hash["Public Key"] + "\n") }
  File.chmod(0644,pub)
  File.chmod(0600,pri)
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

def wait_for_user
  puts
  puts "Press RETURN to continue or any other key to abort"
  c = getc
  # we test for \r and \n because some stuff does \r instead
  abort unless (c == 13) || (c == 10)
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

def user_only_chmod?(d)
  return false unless File.directory?(d)
  mode = File.stat(d).mode & 0777
  # u = (mode >> 6) & 07
  # g = (mode >> 3) & 07
  # o = (mode >> 0) & 07
  mode != 0755
end

def chmod?(d)
  File.exist?(d) && !(File.readable?(d) && File.writable?(d) && File.executable?(d))
end

def chown?(d)
  !File.owned?(d)
end

def chgrp?(d)
  !File.grpowned?(d)
end


def mkdir_p(dir,mode)
  if Dir.exists?(dir)
    if File.stat(dir).to_s(8)[3..5] != "700"
      ohai "Fixing permissions on #{dir}"
      abort "Cound't chmod #{dir}" unless File.chmod(0700,dir)
    end
    sudo "/usr/sbin/chown", ENV["USER"], dir if chown?(dir)
    sudo "/usr/bin/chgrp", "staff", dir if chgrp?(dir)
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
abort "Already installed nothing to do" if Dir.exists?( File.join(Dir.home,"Projects","dotfiles") ) 
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
mkdir_p(0700,PROJECTS_DIR)

# unless File.exists(File.joi(SSH_DIR,'config'))
#   #this is temporary as dotfiles will replace config but it ensures the SSH KEY is stored

#   Host *
#  AddKeysToAgent yes
#  UseKeychain yes
#  IdentityFile ~/.ssh/id_rsa
# end
ohai "Login to LastPass to Retrieve SSH Keys"

#print "LastPass Login Email: "
#email = gets.chomp
#abort "Must provide login to continue!" unless email != ""
#system 'lpass', 'login', email




list = capture_system 'lpass','ls','SysConfig'
found = false
secure_env = ""
list.scan(/^SysConfig\/(.*?) \[id: (\d+)\]$/m) do |match|
  (name,id) = match
  if name == "Primary SSH Key"
    provision_sshkey(id)
    #puts "PKEY! #{id}"
  elsif name == "Secure Env Vars"
    result = capture_system 'lpass', 'show', id
    if result =~ /Notes:\W+(.*?)\Z/m
      secure_env = $1
    end
  elsif name =~ /\ASSH Key \((.*?)\)\Z/
    #provision_sshkey(id,$1)
    #puts "SSH KEY: #{$1} #{id}"
  end
  found = true
  #puts "Found: #{match}" 
end
abort "No secure notes found in list SysConfig group on LastPass" unless found

system 'ssh-add',File.join(Dir.home,'.ssh','id_rsa')
Dir.chdir(Dir.home) do
  system 'git', 'clone', 'git@bitbucket.org:sdhall/dotfiles.git'
end


abort "NOT DONE YET"


user_chmods = zsh_dirs.select { |d| user_only_chmod?(d) }
chmods = group_chmods + user_chmods
chowns = chmods.select { |d| chown?(d) }
chgrps = chmods.select { |d| chgrp?(d) }
mkdirs = %w[Cellar Homebrew Frameworks bin etc include lib opt sbin share share/zsh share/zsh/site-functions var].
         map { |d| File.join(HOMEBREW_PREFIX, d) }.
         reject { |d| File.directory?(d) }

unless group_chmods.empty?
  ohai "The following existing directories will be made group writable:"
  puts(*group_chmods)
end
unless user_chmods.empty?
  ohai "The following existing directories will be made writable by user only:"
  puts(*user_chmods)
end
unless chowns.empty?
  ohai "The following existing directories will have their owner set to #{Tty.underline}#{ENV["USER"]}#{Tty.reset}:"
  puts(*chowns)
end
unless chgrps.empty?
  ohai "The following existing directories will have their group set to #{Tty.underline}admin#{Tty.reset}:"
  puts(*chgrps)
end

ohai "The following new directories will be created:"
puts SSH_DIR.to_s
puts(*mkdirs) unless mkdirs.empty?



wait_for_user if STDIN.tty? && !ENV["TRAVIS"]


if should_install_command_line_tools?
  ohai "Searching online for the Command Line Tools"
  # This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools
  clt_placeholder = "/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
  sudo "/usr/bin/touch", clt_placeholder
  clt_label = `/usr/sbin/softwareupdate -l | grep -B 1 -E "Command Line (Developer|Tools)" | awk -F"*" '/^ +\\*/ {print $2}' | sed 's/^ *//' | tail -n1`.chomp
  ohai "Installing #{clt_label}"
  sudo "/usr/sbin/softwareupdate", "-i", clt_label
  sudo "/bin/rm", "-f", clt_placeholder
  sudo "/usr/bin/xcode-select", "--switch", "/Library/Developer/CommandLineTools"
end

# Headless install may have failed, so fallback to original 'xcode-select' method
if should_install_command_line_tools? && STDIN.tty?
  ohai "Installing the Command Line Tools (expect a GUI popup):"
  sudo "/usr/bin/xcode-select", "--install"
  puts "Press any key when the installation has completed."
  getc
  sudo "/usr/bin/xcode-select", "--switch", "/Library/Developer/CommandLineTools"
end

abort <<-EOABORT if `/usr/bin/xcrun clang 2>&1` =~ /license/ && !$?.success?
You have not agreed to the Xcode license.
Before running the installer again please agree to the license by opening
Xcode.app or running:
    sudo xcodebuild -license
EOABORT


ohai "Cloning dotfiles repository"
Dir.chdir HOMEBREW_REPOSITORY do
  # we do it in four steps to avoid merge errors when reinstalling
  system git, "init", "-q"

  # "git remote add" will fail if the remote is defined in the global config
  system git, "config", "remote.origin.url", BREW_REPO
  system git, "config", "remote.origin.fetch", "+refs/heads/*:refs/remotes/origin/*"

  # ensure we don't munge line endings on checkout
  system git, "config", "core.autocrlf", "false"

  args = git, "fetch", "origin", "master:refs/remotes/origin/master",
        "--tags", "--force"
  system(*args)

  system git, "reset", "--hard", "origin/master"

  system "ln", "-sf", "#{HOMEBREW_REPOSITORY}/bin/brew", "#{HOMEBREW_PREFIX}/bin/brew"

  system "#{HOMEBREW_PREFIX}/bin/brew", "update", "--force"

end

ohai "Installation successful!"
puts

# Use the shell's audible bell.
print "\a"
