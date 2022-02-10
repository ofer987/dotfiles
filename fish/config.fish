# Fisher plugin manager
# Install from https://github.com/fisherman/fisherman
# curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
# fisher install edc/bass
# fisher install oh-my-fish/theme-coffeeandcode
# fisher install dracula/fish

# Viscosity VPN
source "$HOME/.yadr/fish/functions/viscosity.fish"
alias "vpn=connect_vpn"

# Open local webservers
source "$HOME/.yadr/fish/functions/local_servers.fish"

# GitHub functions
source "$HOME/.yadr/fish/functions/github.fish"

# Bin Stubs
source "$HOME/.yadr/fish/functions/bin_stubs.fish"

# Edit command buffer
source "$HOME/.yadr/fish/functions/command_buffer.fish"

if [ -e "$HOME/.yadr/fish/config.personal.fish" ]
  source "$HOME/.yadr/fish/config.personal.fish"
end

set -x EDITOR nvim

# Remove the "Welcome to fish" greeting message
set fish_greeting

fish_vi_key_bindings

function fish_user_key_bindings
  bind --mode default \ce edit_command_buffer
  bind --mode insert \ce edit_command_buffer
  bind --mode visual \ce edit_command_buffer
  bind --erase --mode default \cl
  bind --erase --mode insert \cl
  bind --erase --mode visual \cl
end

set -x NVM_DIR ~/.nvm

set -x GOPATH ~/go
set -x PATH ~/.rbenv/shims ~/.yadr/scripts $PATH $GOPATH/bin
set -x PGDATA ~/Library/Application\ Support/Postgres/var-9.6/
set -x DOTNET_CLI_TELEMETRY_OPTOUT true

alias "ctop=top -o cpu"

alias "ntmux=tmux new-session -n shell"

alias "prs=git pulls | xargs open"

# Vi like
alias ":q=exit"
alias ":Q=exit"

function vi
  nvim $argv
end

alias view=nvim
alias vimdiff=nvim
alias vii='vi +"set ft=ruby"'
alias rvii='vi -R +"set ft=ruby"'
alias rc='doctl compute droplet list'

# alias cat='ccat'
# alias less='lless'

alias "travis-build=travis logs (git rev-parse --abbrev-ref HEAD)"

# Python
alias python=python3

# dotnet core
alias dr='dotnet run'
alias db='dotnet build'
alias dt='dotnet test'

# less
alias il='less -i'

status --is-interactive; and source (rbenv init -|psub)

function latest
  set -x head "./"
  set -x arg_count (count $argv)
  if math "$arg_count > 0" > /dev/null
    set -x head $argv[1]
  end
  for tail in (ls $head)
    echo "$head/$tail"
  end
end


# start Starship
starship init fish | source

function project
  git rev-parse --show-toplevel 2> /dev/null
end

function af
  set -x root (project)

  if [ -z $root ]
    set -x root "."
  end

  echo $argv[1] | awk -v project=$root '
    {
      count = split($0, array, /\//)

      file = array[count]
      app = project "/app"
      spec = project "/spec"
      for (i = 1; i < count; ++i)
      {
        app = app "/" array[i]
        spec = spec "/" array[i]
      }

      system("mkdir -p " app)
      system("mkdir -p " spec)

      system("touch " app "/" file ".rb")
      system("touch " spec "/" file "_spec.rb")
    }
  '
end

function nvm
  bass source $NVM_DIR/nvm.sh --no-use ';' nvm $argv
end
nvm use --silent

function rdb
  pg_ctl restart
end

function root
  cd (project)
end

# Get the file/directory's parent
function get_parent
  set items (string split / $argv[1])
  set count (count $items)

  set count (math $count - 1)

  set i 0
  set result ""
  for item in $items
    if test -n $item && test $i -lt $count
      set result "$result/$item"
    end

    set i (math $i + 1)
  end

  echo $result
end

# cd into the file's directory
function ccd
  set dir $argv[1];

  if test -z $dir
    return 1;
  end

  while test -n $dir
    if test -d $dir
      cd $dir
      return 0
    else
      set parent (get_parent $dir)
      set dir $parent
    end
  end

  return 1
end
