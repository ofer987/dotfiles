" Use deoplete.
let g:deoplete#enable_at_startup = 1

"don't autoselect first item in omnicomplete, show if only one item (for preview)
"remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif
