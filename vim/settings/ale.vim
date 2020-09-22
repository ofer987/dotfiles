let g:ale_enabled = 1
let g:ale_emit_conflict_warnings = 0

nnoremap <leader>en :ALENextWrap<CR>
nnoremap <leader>ep :ALEPreviousWrap<CR>

nnoremap <leader>an :ALENextWrap<CR>
nnoremap <leader>ap :ALEPreviousWrap<CR>
nnoremap <leader>ad :ALEDetail<CR>

nnoremap <C-n> :ALENextWrap<CR>
nnoremap <C-p> :ALEPreviousWrap<CR>

let g:ale_linters = {'markdown': ['writegood'], 'cs': ['OmniSharp']}
