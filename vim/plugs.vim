" ========================================
" Vim plugin configuration
" ========================================
"
" Filetype off is required by plug
filetype off

call plug#begin('~/.yadr/vim/plugged')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-go', { 'do': 'make'}
  Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
  Plug 'pbogut/deoplete-elm'
  Plug 'dracula/vim', { 'as': 'dracula' }
endif


call plug#end()

"Filetype plugin indent on is required by plug
filetype plugin indent on
