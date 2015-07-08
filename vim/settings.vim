let vimsettings = '~/.vim/settings'
let uname = system("uname -s")

for fpath in split(globpath(vimsettings, '*.vim'), '\n')

  if (fpath == expand(vimsettings) . "/yadr-keymap-mac.vim") && uname[:4] ==? "linux"
    continue " skip mac mappings for linux
  endif

  if (fpath == expand(vimsettings) . "/yadr-keymap-linux.vim") && uname[:4] !=? "linux"
    continue " skip linux mappings for mac
  endif

  exe 'source' fpath
endfor

" Visual
set wrap
set relativenumber

set listchars=tab:\ ·
set listchars+=trail:·
set listchars+=extends:»,precedes:«

" Shortcuts
noremap <Leader>q :quit<CR>

command W w
command Q q

nnoremap <silent> <leader>h :NERDTreeToggle<CR>

" vim-go already provides syntax checking
let g:syntastic_ignore_files = ['\.go$']
