let g:ale_enabled = 1
let g:ale_emit_conflict_warnings = 0

nnoremap <leader>afu :ALEFindReferences<CR>
nnoremap <leader>afd :ALEGoToDefinition<CR>
nnoremap <leader>aft :ALEGoToTypeDefinition<CR>

nnoremap <leader>an :ALENextWrap<CR>
nnoremap <leader>ao :ALEDetail<CR>
nnoremap <leader>ac :pclose<CR>

nnoremap <C-n> :ALENextWrap<CR>
nnoremap <C-p> :ALEPreviousWrap<CR>

nnoremap <leader>qf :ALEFix<CR>

let g:ale_linters = {
      \ 'markdown': ['writegood'],
      \ 'cs': ['OmniSharp', 'dotnet-format', 'csc']
      \ }
let g:ale_cs_dotnet_format_executable = 'dotnet'
let g:ale_fixers = {
      \ 'cs': ['dotnet-format', 'remove_trailing_lines', 'trim_whitespace'],
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['eslint'],
      \ }
" let g:ale_fixers = { 'dotnet-format' }
let g:ale_linters_ignore = {
      \ 'javascript': ['jshint', 'eslint'],
      \ 'json': ['eslint'], 'markdown': ['writegood']
      \ }
let g:ale_pattern_options = {
      \ '\.tsx?$': {'ale_enabled': 0},
      \ '\.s?css$': {'ale_enabled': 0}
      \ }
