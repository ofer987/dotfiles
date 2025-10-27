let g:ruby_indent_block_style = 'do'
let g:ruby_indent_assignment_style = 'variable'

autocmd FileType ruby map gj ]m
autocmd FileType ruby map gk [m

function! InsertRubyDebugger(text) abort
  " Current position
  let currentpos = getcurpos()

  " Insert debugging statement
  call append(getcurpos()[1] - 1, repeat(' ', indent('.')) . a:text)

  " Revert to previous position
  call setpos('.', currentpos)
endfunction

" TODO: it assumes that the directory is the name before the file path
" This causes problems when searching within a nested directory
function ToggleCodeToSpec() abort
  let currentFile = expand('%')
  let fullDirectory = expand('%:p:h')
  let directories = split(fullDirectory, '/')

  if currentFile =~ '^lib'
    let projectDirectory = directories[-1]
    let specFile = substitute(currentFile, '^lib/' . projectDirectory . '/', 'spec/', '')
    let specFile = substitute(specFile, '\.rb$', '_spec.rb', '')

    execute 'edit' specFile
  elseif currentFile =~ '^spec'
    let projectDirectory = directories[-2]
    let codeFile = substitute(currentFile, '^spec/', 'lib/' . projectDirectory . '/', '')
    let codeFile = substitute(codeFile, '_spec\.rb', '.rb', '')

    execute 'edit' codeFile
  endif
endfunction

autocmd FileType ruby map <leader>dp :call InsertRubyDebugger("require 'pry-byebug'")<CR>
autocmd FileType ruby map <leader>ds :call InsertRubyDebugger("binding.pry")<CR>

autocmd FileType ruby map <leader>dr :call ToggleCodeToSpec()<CR>
