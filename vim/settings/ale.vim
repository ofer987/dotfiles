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

let g:ale_linters = {'markdown': ['writegood'], 'cs': ['OmniSharp']}
let g:ale_linters_ignore = {'javascript': ['jshint', 'eslint'], 'json': ['eslint'], 'markdown': ['writegood']}
