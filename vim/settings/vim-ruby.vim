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

function ChangeToSpec() abort
  let currentFile = expand('%')

  if currentFile =~ '^lib'
    let specFile = substitute(currentFile, '^lib\/jack_compiler\/', 'spec/', '')
    let specFile = substitute(specFile, '\.rb$', '_spec.rb', '')

    execute 'edit' specFile
  elseif currentFile =~ '^spec'
    let codeFile = substitute(currentFile, '^spec\/', 'lib/jack_compiler/', '')
    let codeFile = substitute(codeFile, '_spec\.rb', '.rb', '')

    execute 'edit' codeFile
  endif
endfunction

autocmd FileType ruby map <leader>dp :call InsertRubyDebugger("require 'pry-byebug'")<CR>
autocmd FileType ruby map <leader>ds :call InsertRubyDebugger("binding.pry")<CR>

autocmd FileType ruby map <leader>dr :call ChangeToSpec()<CR>
