let g:coc_disable_startup_warning = 1

if has('nvim')
  autocmd BufEnter * let g:coc_start_at_startup = 0


  autocmd BufEnter *.rb,*.sh,*.tsx,*.js,*.ts,*.css,*.scss,*.less,*.json,*.go,*.ps1,*.py,*.svelte let g:coc_start_at_startup = 1
  autocmd BufEnter *.rb,*.sh,*.tsx,*.js,*.ts,*.css,*.scss,*.less,*.json,*.go,*.ps1.*.py,*.svelte call execute('CocEnable')

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
        \ coc#pum#visible() ? coc#pum#confirm() :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " TypeScript
  " npm install -g typescript typescript-language-server
  " And then run :CocInstall coc-tsserver in Neovim
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go,ps1,python,svelte nmap <silent> gd <Plug>(coc-definition)
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go,ps1,python,svelte map <silent> <leader>ft <Plug>(coc-type-definition)
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go,ps1,python,svelte map <silent> <leader>fi <Plug>(coc-implementation)
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go,ps1,python,svelte map <silent> <leader>fu <Plug>(coc-references)
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go,ps1,python,svelte map <silent> <leader>nm <Plug>(coc-rename)

  " Cycle errors for all filetypes
  autocmd BufEnter * map <leader>an :ALENextWrap<CR>
  autocmd BufEnter * map <leader>ap :ALEPreviousWrap<CR>

  " But use Coc for these filetypes because it works better!
  autocmd BufEnter *.sh,*.tsx,*.js,*.ts,*.css,*.scss,*.less,*.json,*.go,*.ps1,*.py,*.svelte map <C-n> <Plug>(coc-diagnostic-next)
  autocmd BufEnter *.sh,*.tsx,*.js,*.ts,*.css,*.scss,*.less,*.json,*.go,*.ps1,*.py,*.svelte map <C-p> <Plug>(coc-diagnostic-prev)

  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go,ps1,python,svelte map <silent> <leader>fl :CocList<cr>
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go,ps1,python,svelte map <silent> <leader>fh :CocList outline -kind class<cr>
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go,ps1,python,svelte map <silent> <leader>fj :CocList outline -kind method<cr>
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go,ps1,python,svelte map <silent> <leader>fk :CocList outline -kind function<cr>

  silent! unmap ,fk

  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go,ps1,python,svelte map <silent> gk :CocPrev<cr>
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go,ps1,python,svelte map <silent> gj :CocNext<cr>
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go,ps1,python,svelte map <silent> <leader>gk :CocPrev<cr>
  autocmd FileType ruby,sh,typescriptreact,javascript,typescript,typescript.tsx,css,scss,less,json,go,ps1,python,svelte map <silent> <leader>gj :CocNext<cr>
else
  :silent! CocDisable
endif
