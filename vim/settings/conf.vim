autocmd FileType conf set filetype=apache
autocmd FileType vars set filetype=apache
autocmd FileType vhost set filetype=apache
autocmd FileType any set filetype=apache
autocmd BufEnter *.any set filetype=apache

autocmd BufEnter *.any set noexpandtab
autocmd BufLeave *.any set expandtab
