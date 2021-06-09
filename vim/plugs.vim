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

Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ap/vim-css-color'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'airblade/vim-rooter'
Plug 'chr4/nginx.vim'
Plug 'adamclerk/vim-razor'
Plug 'groenewege/vim-less'
" Run these commands as well
" npm install -g vim-language-server
" gem install solargraph
" pip install python-language-server
" npm install -g typescript typescript-language-server
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'yami-beta/asyncomplete-omni.vim'
Plug 'andreypopp/asyncomplete-ale.vim'
Plug 'mattn/emmet-vim'
Plug 'arthurxavierx/vim-caser'

call plug#end()

let vimsettings = '~/.vim/plug_settings'
for fpath in split(globpath(vimsettings, '*.vim'), '\n')
  exe 'source' fpath
endfor
