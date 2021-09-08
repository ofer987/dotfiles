" JavaScript
autocmd FileType javascript.jsx set shiftwidth=2

" TypeScript
autocmd FileType typescript set shiftwidth=2
autocmd FileType typescriptreact set shiftwidth=2
autocmd FileType typescript.tsx set shiftwidth=2

" JSON
autocmd FileType json set shiftwidth=2

" Rescan file for better JavaScript / TypeScript syntax highlighting
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
