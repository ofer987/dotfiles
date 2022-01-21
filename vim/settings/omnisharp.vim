" Use the stdio version of OmniSharp-roslyn - this is the default
let g:OmniSharp_server_stdio = 1

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview', 'popup'
" and 'popuphidden' if you don't want to see any documentation whatsoever.
" Note that neovim does not support `popuphidden` or `popup` yet:
" https://github.com/neovim/neovim/issues/10996
let g:OmniSharp_popup = 0
if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  " Highlight the completion documentation popup background/foreground the same as
  " the completion menu itself, for better readability with highlighted
  " documentation.
  set completepopup=highlight:Pmenu,border:off
else
  set completeopt=longest,menuone,preview
  " Set desired preview window height for viewing documentation.
  set previewheight=5
endif

"Super tab settings - uncomment the next 4 lines
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
"let g:SuperTabClosePreviewOnPopupClose = 1

" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono)
" By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
" you need it with the :OmniSharpDocumentation command.
" let g:omnicomplete_fetch_full_documentation=1

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
