autocmd BufEnter * call execute('CocDisable')
autocmd BufEnter * let g:asyncomplete_auto_completeopt = 1
autocmd BufEnter *.tsx,*.ts,*.css,*.scss,*.less,*.json,*.go call execute('CocEnable')
autocmd BufEnter *.tsx,*.ts,*.css,*.scss,*.less,*.json,*.go let g:asyncomplete_auto_completeopt = 0

autocmd BufEnter * let g:asyncomplete_auto_popup = 1
autocmd BufEnter *.tsx,*.ts,*.css,*.scss,*less,*.json let g:asyncomplete_auto_popup = 0

autocmd FileType scss setl iskeyword+=@-@

" TypeScript
" npm install -g typescript typescript-language-server
" And then run :CocInstall coc-tsserver in Neovim
autocmd FileType typescriptreact,typescript,typescript.tsx,css,scss,less,json,go nmap <silent> gd <Plug>(coc-definition)
autocmd FileType typescriptreact,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>ft <Plug>(coc-type-definition)
autocmd FileType typescriptreact,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>fi <Plug>(coc-implementation)
autocmd FileType typescriptreact,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>fu <Plug>(coc-references)
autocmd FileType typescriptreact,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>nm <Plug>(coc-rename)
autocmd FileType typescriptreact,typescript,typescript.tsx,css,scss,less,json,go map <silent> <C-n> <Plug>(coc-diagnostic-next)
autocmd FileType typescriptreact,typescript,typescript.tsx,css,scss,less,json,go map <silent> <C-p> <Plug>(coc-diagnostic-prev)
autocmd FileType typescriptreact,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>fl :CocList outline<cr>
autocmd FileType typescriptreact,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>qo :CocListResume<cr>
autocmd FileType typescriptreact,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>qc :CocListCancel<cr>
autocmd FileType typescriptreact,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>sp :CocRestart<cr> | let g:asyncomplete_auto_popup = 0
autocmd FileType typescriptreact,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>qp :CocPrev<cr>
autocmd FileType typescriptreact,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>qn :CocNext<cr>
