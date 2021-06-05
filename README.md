1. `ln -s ~/.yadr/vim ~/.vim;`
1. `ln -s ~/.yadr/vimrc ~/.vimrc;`
1. `ln -s ~/.yadr/tmux/tmux.conf ~/.tmux.conf;`
1. `ln -s ~/.yadr/tmux/tmux.user.conf. ~/.tmux.user.conf;`
1. `ln -s ~/.yadr/irb/pryrc ~/.pryrc;`
1. `ln -s ~/.yadr/irb/aprc ~/.aprc;`
1. `sh ~/vim/dein/installer.sh ~/vim/dein;`
1. `nvim +PlugClean +PlugInstall +PlugUpdate;`
1. `nvim +PluginClean +PluginInstall +PluginUpdate;`
1. `nvim +OmniSharpInstall;`
1. `mkdir -p ~/.config;`
1. `ln -s ~/.yadr/fish ~/.config/fish;`
1. `ln -s ~/.yadr/rubocop ~/.config/rubocop;`
1. `ln -s ~/.yadr/karabiner ~/.config/karabiner;`
1. `fisher install;`

TODO: Consider moving the entire ~/.config directory into ~/.yadr and then adding a .gitignore file within it to preclude machine-dependent files
