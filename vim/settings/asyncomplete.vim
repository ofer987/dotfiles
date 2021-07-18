" Settings
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

" Python
if executable('pyls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

" OmniSharp
call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
      \ 'name': 'omni',
      \ 'allowlist': ['*'],
      \ 'blocklist': ['c', 'cpp', 'html'],
      \ 'completor': function('asyncomplete#sources#omni#completor'),
      \ 'config': {
      \   'show_source_kind': 1
      \ }
      \ }))

" Ruby
if executable('solargraph')
  " gem install solargraph
  au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif

" JavaScript
au User lsp_setup call lsp#register_server({
      \ 'name': 'javascript support using typescript-language-server',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
      \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
      \ 'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact'],
      \ })

" TypeScript
if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx', 'typescriptreact'],
        \ })
endif

" Vimscript
if executable('vim-language-server')
  augroup LspVim
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'vim-language-server',
          \ 'cmd': {server_info->['vim-language-server', '--stdio']},
          \ 'whitelist': ['vim'],
          \ 'initialization_options': {
          \   'vimruntime': $VIMRUNTIME,
          \   'runtimepath': &rtp,
          \ }})
  augroup END
endif

" Emmet
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#emmet#get_source_options({
      \ 'name': 'emmet',
      \ 'whitelist': ['html'],
      \ 'completor': function('asyncomplete#sources#emmet#completor'),
      \ }))

au User asyncomplete_setup call asyncomplete#ale#register_source({
      \ 'name': 'reason',
      \ 'linter': 'flow',
      \ })
