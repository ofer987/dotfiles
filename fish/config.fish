# Fisher plugin manager
# Install from https://github.com/fisherman/fisherman
# curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
# fisher install ssh-agent
source "$HOME/.yadr/fish/functions/fisher.fish"

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

set -x EDITOR nvim

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

alias python=python2

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

function root
  cd (project)
end
