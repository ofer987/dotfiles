" Use the stdio version of OmniSharp-roslyn - this is the default
let g:OmniSharp_server_stdio = 1

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
let g:OmniSharp_popup_position = 'peek'
if has('nvim')
  let g:OmniSharp_popup_options = {
        \ 'winblend': 30,
        \ 'winhl': 'Normal:Normal,FloatBorder:ModeMsg',
        \ 'border': 'rounded'
        \}
else
  let g:OmniSharp_popup_options = {
        \ 'highlight': 'Normal',
        \ 'padding': [0],
        \ 'border': [1],
        \ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
        \ 'borderhighlight': ['ModeMsg']
        \}
endif
let g:OmniSharp_popup_mappings = {
      \ 'sigNext': '<C-n>',
      \ 'sigPrev': '<C-p>',
      \ 'pageDown': ['<C-f>', '<PageDown>'],
      \ 'pageUp': ['<C-b>', '<PageUp>']
      \}

" Fetch semantic type/interface/identifier names on BufEnter and highlight them
let g:OmniSharp_highlight_types = 1

augroup omnisharp_commands
  autocmd!

  autocmd FileType cs set omnifunc=
  autocmd FileType cs set cmdheight=2
  autocmd FileType cs set shiftwidth=4

  "The following commands are contextual, based on the current cursor position.

  autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
  autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
  autocmd FileType cs nnoremap <leader>ot :OmniSharpFindType<cr>
  autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
  autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
  "finds members in the current buffer
  autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
  " cursor can be anywhere on the line containing an issue
  autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
  autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
  autocmd FileType cs nnoremap <leader>ft :OmniSharpTypeLookup<cr>
  autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>

  " navigate up by method/property/field
  autocmd FileType cs nnoremap gk :OmniSharpNavigateUp<cr>

  " navigate down by method/property/field
  autocmd FileType cs nnoremap gj :OmniSharpNavigateDown<cr>

  " Contextual code actions (requires CtrlP or unite.vim)
  autocmd FileType cs nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
  " Run code actions with text selected in visual mode to extract method
  autocmd FileType cs vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

  " rename with dialog
  autocmd FileType cs nnoremap <leader>nm :OmniSharpRename<cr>
  autocmd FileType cs nnoremap <F2> :OmniSharpRename<cr>
  " rename without dialog - with cursor on the symbol to rename... ':Rename newname'
  autocmd FileType cs command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

  " Force OmniSharp to reload the solution. Useful when switching branches etc.
  autocmd FileType cs nnoremap <leader>c= :OmniSharpCodeFormat<cr>
  " Load the current .cs file to the nearest project
  autocmd FileType cs nnoremap <leader>op :OmniSharpAddToProject<cr>

  " Start the omnisharp server for the current solution
  autocmd FileType cs nnoremap <leader>ss :OmniSharpStartServer<cr>
  autocmd FileType cs nnoremap <leader>sp :OmniSharpStopServer<cr>

  " Add syntax highlighting for types and interfaces
  autocmd FileType cs nnoremap <leader>sh :OmniSharpHighlightTypes<cr>

  autocmd FileType cs nnoremap <leader>qf :AsyncRun -post=echo\ "Finished\ Executing\ dotnet-format" dotnet format<cr>
augroup END
