" let g:OmniSharp_want_snippet=1
"
" let g:OmniSharp_start_without_solution=1
" let g:omnisharp_proc_debug=0
" let g:OmniSharp_server_use_mono=0

" Use the stdio version of OmniSharp-roslyn - this is the default
let g:OmniSharp_server_stdio = 1

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview', 'popup'
" and 'popuphidden' if you don't want to see any documentation whatsoever.
" Note that neovim does not support `popuphidden` or `popup` yet:
" https://github.com/neovim/neovim/issues/10996
let g:OmniSharp_popup = 1
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

" let g:OmniSharp_server_type = 'roslyn'
" let g:OmniSharp_selector_ui = 'ctrlp'

" let g:OmniSharp_server_path = '/Users/ofer987/.yadr/vim/omnisharp-roslyn/omnisharp/OmniSharp.exe'

"This is the default value, setting it isn't actually necessary
" let g:OmniSharp_port = 2000

"Set the type lookup function to use the preview window instead of the status line
"let g:OmniSharp_typeLookupInPreview = 1

"Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 1

"Showmatch significantly slows down omnicomplete
"when the first match contains parentheses.
set noshowmatch

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

"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
"You might also want to look at the echodoc plugin
set splitbelow

" Get Code Issues and syntax errors
" let g:syntastic_cs_checkers = ['code_checker']
let g:ale_linters = {
  \ 'cs': ['OmniSharp']
\}

" Fetch semantic type/interface/identifier names on BufEnter and highlight them
let g:OmniSharp_highlight_types = 1

augroup omnisharp_commands
  autocmd!

  "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
  autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

  "The following commands are contextual, based on the current cursor position.

  autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
  autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
  autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
  autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
  autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
  "finds members in the current buffer
  autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
  " cursor can be anywhere on the line containing an issue
  autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
  autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
  autocmd FileType cs nnoremap <leader>ot :OmniSharpTypeLookup<cr>
  autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>

  " navigate up by method/property/field
  autocmd FileType cs nnoremap [[ :OmniSharpNavigateUp<cr>

  " navigate down by method/property/field
  autocmd FileType cs nnoremap ]] :OmniSharpNavigateDown<cr>

augroup END

autocmd FileType cs set shiftwidth=4

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
autocmd FileType cs nnoremap <leader>rl :OmniSharpReloadSolution<cr>
autocmd FileType cs nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
autocmd FileType cs nnoremap <leader>op :OmniSharpAddToProject<cr>

" Start the omnisharp server for the current solution
autocmd FileType cs nnoremap <leader>ss :OmniSharpStartServer<cr>
autocmd FileType cs nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
autocmd FileType cs nnoremap <leader>sh :OmniSharpHighlightTypes<cr>

" Enable snippet completion, requires completeopt-=preview
" autocmd FileType cs autocmd FileType cs set completeopt-=preview

call deoplete#custom#source('omnisharp', 'max_info_width', 0)
