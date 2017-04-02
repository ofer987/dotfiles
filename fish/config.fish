# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

# Functions to initialize the SSH Agent
source "$HOME/.config/fish/functions/ssh_agent_start.fish"

# Viscosity VPN
source "$HOME/.config/fish/yadr_functions/viscosity.fish"
alias "vpn=connect_vpn"

# Open local webservers
source "$HOME/.config/fish/yadr_functions/local_servers.fish"

# GitHub functions
source "$HOME/.config/fish/yadr_functions/github.fish"

fish_vi_mode

set -x PATH ~/.rbenv/shims ~/.yadr/scripts $PATH
set -x PGDATA ~/Library/Application\ Support/Postgres/var-9.6/

alias "ctop=top -o cpu"

alias "ntmux=tmux new-session -n shell"

# Vi like
alias ":q=exit"
alias ":Q=exit"

set -x GOPATH ~/go

export NVM_DIR="$HOME/.nvm"
# bass source /usr/local/opt/nvm/nvm.sh

# function nvm
#   bass source /usr/local/opt/nvm/nvm.sh --no-use ';' nvm $argv
# end
# nvm use default

function vi
  nvim $argv
end

alias view=nvim
alias vimdiff=nvim
alias vii='vi +"set ft=ruby"'

nvm use default

alias "travis-build=travis logs (git rev-parse --abbrev-ref HEAD)"

function run_binstub
  set -x command $argv[1]
  set -x arguments ""
  set -x arg_count (count $argv)
  if math "$arg_count > 1" > /dev/null
    set -x arguments $argv[2..-1]
  end

  set -x PROJECT (git rev-parse --show-toplevel 2> /dev/null)
  if set -q $PROJECT
    set -x PROJECT "."
  end
  set -x FILE $PROJECT/bin/$command

  if not test -e $FILE
    set -x FILE (rbenv which $command)
  end

  if not test -e $FILE
    false
  else
    eval $FILE $arguments
  end
end

function console
  run_binstub rails console
end

function rails
  run_binstub rails $argv
end

function rake
  run_binstub rake $argv
end

function rspec
  run_binstub rspec $argv
end

function guard
  run_binstub guard
end

function stop_spring
  run_binstub spring stop
end

function latest
  set -x head "./"
  set -x arg_count (count $argv)
  if math "$arg_count > 0" > /dev/null
    set -x head $argv[1]
  end
  for tail in (ls -tr $head)
    echo "$head/$tail"
  end
end

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
