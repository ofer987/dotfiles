" Add the dein installation directory into runtimepath
set runtimepath+=~/.yadr/vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.yadr/vim/dein')
  call dein#begin('~/.yadr/vim/dein')

  call dein#add('~/.yadr/vim/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('christoomey/vim-tmux-navigator')

  call dein#end()
  call dein#save_state()
endif
