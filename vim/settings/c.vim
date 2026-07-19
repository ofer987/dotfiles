let g:lsp_clangd_ignore_warning = 1

autocmd BufEnter *.h set ft=c

function! s:switch_from_source_to_test()
  let l:filepath = expand("%:~")
  let l:filename = expand("%:t")
  let l:dirname = expand('%:p:h')

  if l:filepath =~ '\/tests\/test_\(\w\+\)\.c$'
    let l:source_code = substitute(l:filepath, 'tests\/test_\(\w\+\)\.c$', '\1\.c', '')

    execute 'e ' . l:source_code
  elseif l:filename =~ '\.\(c\|h\)$'
    let l:file_base_name = substitute(l:filename, '\(\w\+\)\.\(c\|h\)$', '\1', '')

    let l:test_path = l:dirname . '/tests/test_' . l:file_base_name . '.c'

    if filereadable(l:test_path)
      execute 'e ' . l:test_path
    endif
  else
    echo l:filename . ' does not have a test file'
  endif
endfunction

command! SwitchFromSourceToTest call s:switch_from_source_to_test()
map <silent> <leader>cy :SwitchFromSourceToTest<cr>
