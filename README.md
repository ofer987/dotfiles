## Installation Instructions

Technology | Install Command | Latest Instructions
---------- | --------------- | -------------------
iTerm2 | N/A | https://iterm2.com
Brew | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";` | https://github.com/Homebrew/brew
Neovim | `brew install neovim;` | https://github.com/neovim/neovim
Vim | `brew install vim;` | https://github.com/vim/vim
Tmux | `brew install tmux;` | 
Fish | `brew install fish;` | https://fishshell.com/
Fisher | `curl -sL https://git.io/fisher \| source && fisher install jorgebucaran/fisher;` | https://github.com/jorgebucaran/fisher
Karabiner | N/A | https://github.com/pqrs-org/Karabiner-Elements
Pry | `gem install pry;` | https://github.com/pry/pry
NVM | `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh \| bash;` | https://github.com/nvm-sh/nvm
Git Scripts | N/A | Set the GitHub Personal Authentication Token as `env -x GITHUB_TOKEN <personal-pat>` in `~/.yadr/fish/config.personal.fish`

## Configuration Instructions

### Git-scripts submodule

1. `git submodule update --recursive;`

### Fish and Starship

1. `mkdir -p -- ~/.config;`
1. `ln -s ~/.yadr/fish ~/.config/fish;`
1. `ln -s ~/.yadr/starship.toml ~/.config/starship.toml;`
1. `curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher;`
1. `fisher install edc/bass;`
1. `fisher install oh-my-fish/theme-coffeeandcode;`
1. `fisher install dracula/fish;`

### Starship Cross-shell Prompt

1. Follow the instructions at https://starship.rs/
1. Install the NerdFont FiraCode font for iTerm2

### Neovim and Vim

Install both Neovim and Vim via Brew.

#### vim-plug

1. Install vim-plug, https://github.com/junegunn/vim-plug, for both Neovim and Vim

#### Plugins

1. `ln -s ~/.yadr/vim ~/.vim;`
1. `ln -s ~/.yadr/vimrc ~/.vimrc;`
1. `mkdir -p -- ~/.config/nvim;`
1. `ln -s ~/.yadr/vimrc ~/.config/nvim/init.vim;`
1. `ln -s ~/.yadr/vim/spell ~/.config/nvim/spell;`
1. `nvim +PlugClean +PlugInstall +PlugUpdate;`
1. `vim +PlugClean +PlugInstall +PlugUpdate;`
1. `vim +OmniSharpInstall;`

#### Language Servers

1. `gem install rubocop;`
1. `ln -s ~/.yadr/rubocop/config.yml ~/.rubocop.yml;`
1. `ln -s ~/.yadr/ruby/ruby-version ~/.ruby-version;`
1. `npm install -g vim-language-server;`
1. `gem install solargraph;`
1. `mkdir -p ~/.config/solargraph;`
1. `ln -s ~/.yadr/solargraph.yml ~/.config/solargraph/config.yml;`
1. `pip install python-language-server;`
1. `npm install -g typescript typescript-language-server;`
1. `npm install -g bash-language-server;`
1. `npm install -g vscode-css-languageserver-bin;`
1. `npm install -g vscode-html-languageserver-bin;`
1. `npm install -g dockerfile-language-server-nodejs;`
1. `brew install llvm;`
1. `ln -s ~/.yadr/nvmrc ~/.nvmrc`
1. For TypeScript (via CoC):
  1. execute in Neovim: `:CocInstall coc-tsserver`
  1. execute in Neovim: `:CocInstall coc-css`
  1. execute in Neovim: `:CocInstall coc-json`
  1. execute in Neovim: `:CocInstall coc-solargraph`
  1. execute in shell: `ln -s ~/.yadr/coc-settings.json ~/.config/nvim/coc-settings.json;`

Configure Solargraph by following its [documentation](https://github.com/castwide/solargraph)

### Tmux

1. `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm;`
1. `~/.tmux/plugins/tpm/tpm;`
1. `ln -s ~/.yadr/tmux/tmux.conf ~/.tmux.conf;`
1. `ln -s ~/.yadr/tmux/tmux.user.conf ~/.tmux.user.conf;`
1. Run `~/.tmux/plugins/tpm/tpm`
  - If the Plugins do not exist at `~/.tmux/plugins` then install them manually
    1. `git clone https://github.com/tmux-plugins/tpm`
    1. `git clone git@github.com:tmux-plugins/tmux-yank.git`
    1. `git clone git@github.com:ofer987/tmux-airline-dracula.git`
1. Silence bell:
  1. Preferences -> Profiles -> Terminal -> Silence bell
1. Fonts:
  1. Font Book -> Add -> `~/.yadr/fonts/Fira Code Regular Nerd Font Complete.otf`
  1. Preferences -> Profiles -> Text -> FiraCode Nerd Font

### Pry

1. `ln -s ~/.yadr/irb/pryrc ~/.pryrc;`
1. `ln -s ~/.yadr/irb/aprc ~/.aprc;`

### Karabiner

1. `ln -s ~/.yadr/karabiner ~/.config/karabiner;`

### LaunchBar

1. Install LaunchBar from http://launchbar.com
1. Licence can be found in ofer987@gmail.com email inbox
1. Install custom actions by executing, `~/.yadr/LaunchBar/create_action`

## Future Plans

TODO: Consider moving the entire ~/.config directory into ~/.yadr and then adding a .gitignore file within it to preclude machine-dependent files

## Key Mappings

[Key Mappings](./keymappings.md)
