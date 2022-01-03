autocmd BufEnter * call execute('CocDisable')
autocmd BufEnter *.tsx,*.ts call execute('CocEnable')

autocmd BufEnter * let g:asyncomplete_auto_popup = 1
autocmd BufEnter *.tsx,*.ts let g:asyncomplete_auto_popup = 0

" TypeScript
" npm install -g typescript typescript-language-server
" And then run :CocInstall coc-tsserver in Neovim
autocmd FileType typescriptreact,typescript,typescript.tsx nmap <silent> gd <Plug>(coc-definition)
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <leader>ft <Plug>(coc-type-definition)
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <leader>fi <Plug>(coc-implementation)
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <leader>fu <Plug>(coc-references)
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <leader>nm <Plug>(coc-rename)
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <C-n> <Plug>(coc-diagnostic-next)
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <C-p> <Plug>(coc-diagnostic-prev)
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <leader>fl :CocList outline<cr>
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <leader>fk :CocListResume<cr>
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <leader>sp :CocRestart<cr>
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <leader>qp :CocPrev<cr>
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <leader>qn :CocNext<cr>
