" via: http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\r\+$//e
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! <SID>StripTrailingWhitespacesAndSave()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\r\+$//e
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)

    write
    bdelete
endfunction

command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
command! StripTrailingWhitespacesAndSave call <SID>StripTrailingWhitespacesAndSave()

nmap <leader>w :StripTrailingWhitespaces<CR>
nmap <leader>e :StripTrailingWhitespacesAndSave<CR>
