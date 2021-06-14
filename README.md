## Installation Instructions

Technology | Install Command | Latest Instructions
---------- | --------------- | -------------------
Brew | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` | https://github.com/Homebrew/brew
Neovim | `brew install neovim;` | https://github.com/neovim/neovim
Tmux | `brew install tmux;` | 
Fish | `brew install fish;` | https://fishshell.com/
Fisher | `curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher;` | https://github.com/jorgebucaran/fisher
Karabiner | N/A | https://github.com/pqrs-org/Karabiner-Elements
Pry | `gem install pry` | https://github.com/pry/pry
NVM | `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash` | https://github.com/nvm-sh/nvm


## Configuration Instructions

### Fish

1. `mkdir -p ~/.config;`
1. `ln -s ~/.yadr/fish ~/.config/fish;`
1. `fisher install;`

### Neovim

1. `ln -s ~/.yadr/vim ~/.vim;`
1. `ln -s ~/.yadr/vimrc ~/.vimrc;`
1. `sh ~/vim/dein/installer.sh ~/vim/dein;`
1. `nvim +PlugClean +PlugInstall +PlugUpdate;`
1. `nvim +PluginClean +PluginInstall +PluginUpdate;`
1. `nvim +OmniSharpInstall;`

#### Language Servers

1. `gem install rubocop;`
1. `ln -s ~/.yadr/rubocop ~/.config/rubocop;`
1. `npm install -g vim-language-server`
1. `gem install solargraph`
1. `pip install python-language-server`

### Tmux

1. `ln -s ~/.yadr/tmux/tmux.conf ~/.tmux.conf;`
1. `ln -s ~/.yadr/tmux/tmux.user.conf. ~/.tmux.user.conf;`

### Pry

1. `ln -s ~/.yadr/irb/pryrc ~/.pryrc;`
1. `ln -s ~/.yadr/irb/aprc ~/.aprc;`

### Karabiner

1. `ln -s ~/.yadr/karabiner ~/.config/karabiner;`

## Future Plans

TODO: Consider moving the entire ~/.config directory into ~/.yadr and then adding a .gitignore file within it to preclude machine-dependent files
