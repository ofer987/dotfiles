" Use the stdio version of OmniSharp-roslyn - this is the default
let g:OmniSharp_server_stdio = 1

if has('nvim')
else
  set completeopt=menuone,noinsert,noselect,popuphidden
  set completepopup=highlight:Pmenu,border:off

  " Colors: {{{
  augroup ColorschemePreferences
    autocmd!

    " These preferences clear some gruvbox background colours, allowing transparency
    autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE

    " Link ALE sign highlights to similar equivalents without background colours
    autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
    autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
    autocmd ColorScheme * highlight link ALEInfoSign    Identifier
  augroup END
  " }}}

  " ALE: {{{
  let g:ale_sign_error = '•'
  let g:ale_sign_warning = '•'
  let g:ale_sign_info = '·'
  let g:ale_sign_style_error = '·'
  let g:ale_sign_style_warning = '·'

  let g:ale_linters = { 'cs': ['OmniSharp'] }
  " }}}

  " Asyncomplete: {{{
  let g:asyncomplete_auto_popup = 1
  let g:asyncomplete_auto_completeopt = 0
  " }}}

  " Sharpenup: {{{
  " All sharpenup mappings will begin with `<Space>os`, e.g. `<Space>osgd` for
  " :OmniSharpGotoDefinition
  let g:sharpenup_map_prefix = '<Space>os'
  let g:sharpenup_codeactions_set_signcolumn = 0
  let g:sharpenup_codeactions_glyph = '->'

  let g:sharpenup_statusline_opts = { 'Text': '%s (%p/%P)' }
  let g:sharpenup_statusline_opts.Highlight = 0

  augroup OmniSharpIntegrations
    autocmd!
    autocmd User OmniSharpProjectUpdated,OmniSharpReady call lightline#update()
  augroup END
  " }}}

  " Lightline: {{{
  let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ 'active': {
  \   'right': [
  \     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
  \     ['lineinfo'], ['percent'],
  \     ['fileformat', 'fileencoding', 'filetype', 'sharpenup']
  \   ]
  \ },
  \ 'inactive': {
  \   'right': [['lineinfo'], ['percent'], ['sharpenup']]
  \ },
  \ 'component': {
  \   'sharpenup': sharpenup#statusline#Build()
  \ },
  \ 'component_expand': {
  \   'linter_checking': 'lightline#ale#checking',
  \   'linter_infos': 'lightline#ale#infos',
  \   'linter_warnings': 'lightline#ale#warnings',
  \   'linter_errors': 'lightline#ale#errors',
  \   'linter_ok': 'lightline#ale#ok'
  \  },
  \ 'component_type': {
  \   'linter_checking': 'right',
  \   'linter_infos': 'right',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'right'
  \  }
  \}

  " Use unicode chars for ale indicators in the statusline
  let g:lightline#ale#indicator_checking = "\uf110 "
  let g:lightline#ale#indicator_infos = "\uf129 "
  let g:lightline#ale#indicator_warnings = "\uf071 "
  let g:lightline#ale#indicator_errors = "\uf05e "
  let g:lightline#ale#indicator_ok = "\uf00c "
  " }}}

  " OmniSharp: {{{
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

  let g:OmniSharp_highlight_groups = {
  \ 'ExcludedCode': 'NonText'
  \}
  " }}}

  " Fetch semantic type/interface/identifier names on BufEnter and highlight them
  let g:OmniSharp_highlight_types = 1

  augroup omnisharp_commands
    autocmd!

    autocmd FileType cs set omnifunc=
    autocmd FileType cs set shiftwidth=4

    autocmd FileType cs set backspace=indent,eol,start
    autocmd FileType cs set expandtab
    autocmd FileType cs set shiftround
    autocmd FileType cs set softtabstop=-1
    autocmd FileType cs set tabstop=8
    autocmd FileType cs set textwidth=80
    autocmd FileType cs set title
    autocmd FileType cs set hidden
    autocmd FileType cs set nofixendofline
    autocmd FileType cs set nostartofline
    autocmd FileType cs set splitbelow
    autocmd FileType cs set splitright

    autocmd FileType cs set hlsearch
    autocmd FileType cs set incsearch
    autocmd FileType cs set laststatus=2
    autocmd FileType cs set noruler
    autocmd FileType cs set noshowmode
    autocmd FileType cs set signcolumn=yes

    autocmd FileType cs set mouse=a
    autocmd FileType cs set updatetime=200

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
    autocmd FileType cs nnoremap <leader>dd :OmniSharpDocumentation<cr>

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
endif
