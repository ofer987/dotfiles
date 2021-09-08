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
" Use ALE to show Lsp errors/diagnostics/errors
" In other words, Lsp errors/diagnostics/errors do not show using Lsp
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'andreypopp/asyncomplete-ale.vim'
Plug 'rhysd/vim-lsp-ale'
Plug 'prabirshrestha/asyncomplete-emmet.vim'
Plug 'mattn/emmet-vim'
Plug 'ofer987/vim-caser'
Plug 'airblade/vim-rooter'
Plug 'gisphm/vim-gitignore'
Plug 'plasticboy/vim-markdown'

" JavaScript and TypeScript
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
" Prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

call plug#end()
