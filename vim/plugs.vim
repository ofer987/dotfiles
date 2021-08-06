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
Plug 'chr4/nginx.vim'
Plug 'adamclerk/vim-razor'
Plug 'groenewege/vim-less'
" Run these commands as well
" npm install -g vim-language-server
" gem install solargraph
" pip install python-language-server
" npm install -g typescript typescript-language-server
" npm install -g bash-language-server
" npm install -g vscode-css-languageserver-bin
" npm install -g vscode-html-languageserver-bin
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
" Show Lsp errors/diagnostics/errors only in ALE
Plug 'rhysd/vim-lsp-ale'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'andreypopp/asyncomplete-ale.vim'
Plug 'prabirshrestha/asyncomplete-emmet.vim'
Plug 'mattn/emmet-vim'
Plug 'ofer987/vim-caser'
Plug 'airblade/vim-rooter'
Plug 'gisphm/vim-gitignore'

call plug#end()
