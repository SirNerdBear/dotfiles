# My dotfiles

![Screenshot of my terminal](https://raw.githubusercontent.com/SirNerdBear/dotfiles/master/ss.png)

## Installation

```/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/SirNerdBear/dotfiles/master/install)"```

## TODO

* Create a Finder Sync Extention in order to set Sidebar icons for custom folders
  * https://github.com/onmyway133/FinderGo/
  * https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/Finder.html
  * https://stackoverflow.com/questions/29754914/os-x-finder-sync-extension

* Add an SSH tmux config to change status BAR for remote sessions (location and styling)

* TMUX persistance
  * https://github.com/tmux-plugins/tmux-resurrect/blob/master/README.md
  * https://github.com/tmux-plugins/tmux-resurrect

* Setup GPG
  * https://gist.github.com/ankurk91/c4f0e23d76ef868b139f3c28bde057fc
  * https://gpgtools.tenderapp.com/discussions/problems/10990-location-of-private-key-files-in-system-osx

* https://editorconfig.org/ for VSC, Vim, XCode, etc. 

* Review fonts in brew-cask.sh

* Look at https://www.trankynam.com/xtrafinder/

* Figure out how to copy private fonts from Dropbox (or other) and keep it private

* Review commented out apps in brew.sh and see what we might want/need
  * See if any from https://gist.github.com/kevinelliott/ab14cfb080cc85e0f8a415b147a0d895 should be added

* Installer
  * Rename so this will work:
    ```/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/SirNerdBear/dotfiles/master/install)"```
    * Possibly make easier with a shorter URL
  * Make .gitconfig.local via extracted ENV vars
  * PIP installs https://gist.github.com/patriciogonzalezvivo/77da993b14a48753efda

* CMUS
  * https://github.com/alextercete/cmus-theme-screenshot and other cmux configuration settings
  * Finish importing all music

* Finish BTT Config
  * Need a "PC" mouse to setup backbutton/forward button

* Testing
  * https://www.amazon.com/Optical-SuperDrive-Adapter-Unibody-Macbook/dp/B004FM4UGE
  * Using a spare disk we can create new installs without effecting production system

* Tmuxinator setup
  * Things I code in
    * Rails(Ruby,HAML,SASS,JS,CoffeeScript,IRB)
    * React(JS,Reacthingmabob)
    * C, C++, C#
    * Kotlin(Android Dev)
    * Swift(macOS, iOS, and watchOS Dev)
    * Arduino(Pretty much C but need minicom for the serial interface and separate Make tools)
    * Python
    * NodeJS
    * Perl
  * Things I'd like to play with:
    * Java
    * Elixar
    * Rust
    * PHP (been awhile good to refresh, YII looks cool)
  * Session templates: Rails, C (make), Python, Ruby, Arduino, macOS Dev
    * Sessions will be created for projects by copying the base template
  * Make a t() function
    * t projectX resumes or starts from the given template
    * t projectX.rails if there is a period then it will make a new tmuxinator profile for that base template
      * ignored if projectX exists
    * t by itself it will resume .lastsession (anyone started by t that is)
    * t -projectX
      * the - sign will cause the template to be deleted and remove .lastsession if it matches
    * IDEAS: https://paulfioravanti.com/blog/2018/01/12/tmuxinator-for-exercism/
    * IDEAS: https://gist.github.com/jyurek/7be666a88e06f68d45cf
    * Suppport autocomplete including changing once the period is typed
  * Setup colored log pane support
    * https://coderwall.com/p/9flnew/easy-and-beautiful-rails-logs
    * https://unix.stackexchange.com/questions/8414/how-to-have-tail-f-show-colored-output
    * http://blog.scoutapp.com/articles/2015/12/09/4-ways-to-get-the-most-out-of-your-rails-logs
  * Rails template
    * vim-rails
    * vimux
    * vim-turbux
    * https://www.youtube.com/watch?v=DteBSo_ZfsA
    * Pry/Guard
    * IDEAS: https://gist.github.com/matsubo/8e9aa12c1ca9dcc7f0f3

* Make a .gitignore_global
  * https://help.github.com/articles/ignoring-files/
  * https://github.com/github/gitignore/blob/master/Global/Vim.gitignore

* Configure startup items in brew.sh or brew-cask.sh
  * http://hints.macworld.com/article.php?story=20111226075701552
  * Docker? It doesn't seem to load the tray app

* Finish TMUX cheat sheet and link here
  * https://til.hashrocket.com/posts/385fee97f3-list-all-tmux-key-bindings
  * https://gist.github.com/henrik/1967800
  * https://www.cheatography.com/nerdbear/cheat-sheets/tmux-binds/


