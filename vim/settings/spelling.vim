autocmd FileType md setlocal spell spelllang=en_gb
autocmd FileType markdown setlocal spell spelllang=en_gb
autocmd FileType gitcommit setlocal spell spelllang=en_gb

map <leader>sl :setlocal spell spelllang=en_gb<cr>
map <leader>sk :setlocal spell spelllang=<cr>
map <leader>s; :mkspell! ~/.yadr/vim/spell/en.utf-8.add<cr>
