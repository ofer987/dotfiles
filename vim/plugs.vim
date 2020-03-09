" ========================================
" Vim plugin configuration
" ========================================
"
" Filetype off is required by plug
filetype off

call plug#begin('~/.yadr/vim/plugged')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-go', { 'do': 'make' }
  Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'wannesm/wmgraphviz.vim'
  Plug 'ap/vim-css-color'
  Plug 'artur-shaik/vim-javacomplete2'
  Plug 'airblade/vim-rooter'
  Plug 'chr4/nginx.vim'
  Plug 'adamclerk/vim-razor'
  Plug 'groenewege/vim-less'
endif


call plug#end()

"Filetype plugin indent on is required by plug
filetype plugin indent on

let vimsettings = '~/.vim/plug_settings'
for fpath in split(globpath(vimsettings, '*.vim'), '\n')
  " exe 'source' fpath
endfor
