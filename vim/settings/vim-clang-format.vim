" Format code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>c= :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>c= :ClangFormat<CR>

" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

nmap <leader>cc :e %:r.c<CR>
nmap <leader>ch :e %:r.h<CR>
