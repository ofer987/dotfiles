# Functions to initialize the SSH Agent
source "$HOME/.yadr/fish/functions/ssh_agent_start.fish"

# Viscosity VPN
source "$HOME/.yadr/fish/functions/viscosity.fish"
alias "vpn=connect_vpn"

# Open local webservers
source "$HOME/.yadr/fish/functions/local_servers.fish"

# GitHub functions
source "$HOME/.yadr/fish/functions/github.fish"

# Bin Stubs
source "$HOME/.yadr/fish/functions/bin_stubs.fish"

set -x EDITOR vim

fish_vi_key_bindings

set -x YARN_BIN (yarn global bin)
set -x PATH ~/.rbenv/shims ~/.yadr/scripts $YARN_BIN $PATH
set -x PGDATA ~/Library/Application\ Support/Postgres/var-9.6/

alias "ctop=top -o cpu"

alias "ntmux=tmux new-session -n shell"

# Vi like
alias ":q=exit"
alias ":Q=exit"

set -x GOPATH ~/go

# Alias GitHub's hub to git
eval (hub alias -s)

set -x RBENV_VERSION "2.3.1"

function vi
  vim $argv
end

alias view=vim
alias vimdiff=vim
alias vii='vi +"set ft=ruby"'

alias "travis-build=travis logs (git rev-parse --abbrev-ref HEAD)"

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

function rdb
  pg_ctl restart
end

function reload
  source ~/.config/fish/config.fish
end
