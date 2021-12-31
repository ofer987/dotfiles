autocmd BufEnter * call execute('CocDisable')
autocmd BufEnter *.tsx,*.ts call execute("CocEnable")

" TypeScript
" npm install -g typescript typescript-language-server
" And then run :CocInstall coc-tsserver in Neovim
autocmd FileType typescriptreact,typescript,typescript.tsx nmap <silent> gd <Plug>(coc-definition)
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <leader>ft <Plug>(coc-type-definition)
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <leader>fi <Plug>(coc-implementation)
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <leader>fu <Plug>(coc-references)
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> <leader>nm <Plug>(coc-rename)
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> gj <Plug>(coc-diagnostic-next)
autocmd FileType typescriptreact,typescript,typescript.tsx map <silent> gk <Plug>(coc-diagnostic-prev)
