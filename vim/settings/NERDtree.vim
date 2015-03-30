" Make nerdtree look nice
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30

nnoremap ,h :NERDTreeToggle<cr>
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
