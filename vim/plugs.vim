" ========================================
" Vim plugin configuration
" ========================================
"
" Filetype off is required by plug
" NOTE: Installation instructions can be found at
" https://github.com/junegunn/vim-plug
" NOTE: Only works on Neovim as of November 2020
filetype off

call plug#begin('~/.yadr/vim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make' }
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ap/vim-css-color'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'airblade/vim-rooter'
Plug 'chr4/nginx.vim'
Plug 'adamclerk/vim-razor'
Plug 'groenewege/vim-less'


call plug#end()

"Filetype plugin indent on is required by plug
filetype plugin indent on

let vimsettings = '~/.vim/plug_settings'
for fpath in split(globpath(vimsettings, '*.vim'), '\n')
  " exe 'source' fpath
endfor
