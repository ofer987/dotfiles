# Installation Instructions

## Brew

Please see https://github.com/Homebrew/brew for latest installation instructions

1. `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

## Neovim

### Installation

Please see https://github.com/neovim/neovim for latest installation instructions

1. `brew install neovim;`

### Configuration

Configure Vim/Neovim

1. `ln -s ~/.yadr/vim ~/.vim;`
1. `ln -s ~/.yadr/vimrc ~/.vimrc;`

## Tmux

### Install Tmux

1. `brew install tmux;`

1. `ln -s ~/.yadr/tmux/tmux.conf ~/.tmux.conf;`
1. `ln -s ~/.yadr/tmux/tmux.user.conf. ~/.tmux.user.conf;`
1. `ln -s ~/.yadr/irb/pryrc ~/.pryrc;`
1. `ln -s ~/.yadr/irb/aprc ~/.aprc;`
1. `sh ~/vim/dein/installer.sh ~/vim/dein;`
1. `nvim +PlugClean +PlugInstall +PlugUpdate;`
1. `nvim +PluginClean +PluginInstall +PluginUpdate;`
1. `nvim +OmniSharpInstall;`
1. `mkdir -p ~/.config;`

### Configurations

#### Fish

1. `ln -s ~/.yadr/fish ~/.config/fish;`

#### Rubocop

For Ruby

1. `ln -s ~/.yadr/rubocop ~/.config/rubocop;`

#### Karabiner

Keyboard configurations

##### Installation

Install the latest version of Karabiner Elements

1. `https://github.com/pqrs-org/Karabiner-Elements`

##### Configuration

1. `ln -s ~/.yadr/karabiner ~/.config/karabiner;`

### NVM

###
Check https://github.com/nvm-sh/nvm for the latest instructions

1. `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash`

### Fisher

#### Installation

Check https://github.com/jorgebucaran/fisher for the latest instructions

1.  `curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher`

#### Plugins

Installs the shell theme and the **nvm** command for Fish

1. `fisher install;`

### Language servers for Neovim

1. `gem install rubocop;`
1. `npm install -g vim-language-server`
1. `gem install solargraph`
1. `pip install python-language-server`

TODO: Consider moving the entire ~/.config directory into ~/.yadr and then adding a .gitignore file within it to preclude machine-dependent files
