let g:coc_disable_startup_warning = 1

if has('nvim')
  autocmd BufEnter * let g:coc_start_at_startup = 0

  autocmd BufEnter * let g:asyncomplete_auto_completeopt = 1
  autocmd BufEnter * let g:asyncomplete_auto_popup = 1

  autocmd BufEnter *.rb,*.sh,*.tsx,*.js,*.ts,*.css,*.scss,*.less,*.json,*.go let g:coc_start_at_startup = 1
  autocmd BufEnter *.rb,*.sh,*.tsx,*.js,*.ts,*.css,*.scss,*.less,*.json,*.go call execute('CocEnable')
  autocmd BufEnter *.rb,*.sh,*.tsx,*.js,*.ts,*.css,*.scss,*.less,*.json,*.go let g:asyncomplete_auto_completeopt = 0
  autocmd BufEnter *.rb,*.sh,*.tsx,*.js,*.ts,*.css,*.scss,*.less,*.json,*.go let g:asyncomplete_auto_popup = 0

  autocmd FileType scss setl iskeyword+=@-@
  " Do not change cursor style if <C-c> is pressed
  let g:coc_disable_transparent_cursor = 1

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300
  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: There's always complete item selected by default, you may want to enable
  " no select by `"suggest.noselect": true` in your configuration file.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " TypeScript
  " npm install -g typescript typescript-language-server
  " And then run :CocInstall coc-tsserver in Neovim
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go nmap <silent> gd <Plug>(coc-definition)
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>ft <Plug>(coc-type-definition)
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>fi <Plug>(coc-implementation)
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>fu <Plug>(coc-references)
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>nm <Plug>(coc-rename)
  autocmd FileType sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go map <silent> <C-n> <Plug>(coc-diagnostic-next)
  autocmd FileType sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go map <silent> <C-p> <Plug>(coc-diagnostic-prev)
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>fl :CocList outline<cr>
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go map <silent> <leader>sp :CocRestart<cr> | let g:asyncomplete_auto_popup = 0
else
  :silent! CocDisable
endif
