# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

# Functions to initialize the SSH Agent
source "$HOME/.config/fish/functions/ssh_agent_start.fish"

fish_vi_mode

# function fish_user_key_bindings
#   for mode in insert default visual
#     bind -M $mode \cf forward-char
#   end
# end
#
# fish_user_key_bindings

set -x PATH ~/.rbenv/shims ~/.yadr/scripts $PATH

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

alias vi=nvim
alias view=nvim
alias vimdiff=nvim
alias vii='vi +"set ft=ruby"'

nvm use default

alias "travis-build=travis logs (git rev-parse --abbrev-ref HEAD)"

function console
  set -x PROJECT (git rev-parse --show-toplevel 2> /dev/null)
  if set -q $PROJECT
  else
    eval $PROJECT/bin/rails c
  end
end

function crake
  set -x PROJECT (git rev-parse --show-toplevel 2> /dev/null)
  if set -q $PROJECT
    eval rake
  else
    echo $argv
    eval $PROJECT/bin/rake $argv
  end
end

function stop_spring
  set -x PROJECT (git rev-parse --show-toplevel 2> /dev/null)
  if set -q $PROJECT
  else
    eval $PROJECT/bin/spring stop
  end
end
