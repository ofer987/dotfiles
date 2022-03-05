# Fisher plugin manager
# Install from https://github.com/fisherman/fisherman
# curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
# fisher install edc/bass
# fisher install oh-my-fish/theme-coffeeandcode
# fisher install dracula/fish

# Viscosity VPN
source "$HOME/.config/fish/my_functions/viscosity.fish"
alias "vpn=connect_vpn"

# Open local webservers
source "$HOME/.config/fish/my_functions/local_servers.fish"

# git functions
source "$HOME/.config/fish/my_functions/git.fish"

# Bin Stubs
source "$HOME/.config/fish/my_functions/bin_stubs.fish"

# supercd functions
source "$HOME/.config/fish/my_functions/supercd.fish"

if [ -e "$HOME/.config/fish/config.personal.fish" ]
  source "$HOME/.config/fish/config.personal.fish"
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
set -x PATH ~/.rbenv/shims ~/.yadr/scripts ~/.yadr/scripts/**/exe $PATH $GOPATH/bin
set -x PGDATA ~/Library/Application\ Support/Postgres/var-9.6/
set -x DOTNET_CLI_TELEMETRY_OPTOUT true

alias "ctop=top -o cpu"

alias "ntmux=tmux new-session -n shell"

alias "prs=git pulls | xargs open"

# Vi like
alias ":q=exit"
alias ":Q=exit"
alias "ZQ=exit"

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

# less with ignore-case search
alias il='less -i'
alias lessi='less -i'

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

# Start Starship
starship init fish | source

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

# Node Version Manager
function nvm
  bass source $NVM_DIR/nvm.sh --no-use ';' nvm $argv
end
nvm use --silent

# Restart PostgreSQL
function rdb
  pg_ctl restart
end
