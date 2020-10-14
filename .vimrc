set t_Co=256
syntax on
map q <Nop>
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
set noincsearch
set nohlsearch
set ignorecase
set clipboard+=unnamedplus
set autoindent
set smarttab
set smartindent
set softtabstop=4
set shiftwidth=4
set expandtab
set number
set laststatus=2
set statusline =\ D:%{getcwd()}	" Working Directory
set statusline+=\ F:%f		" Current file
set statusline+=\ S:%m		" Files's modification state
set statusline+=\ R:%r		" File's permissions
set statusline+=\ T:%y		" File's language type
set statusline+=\ L:%l/%L	" Current line vs lines number

let g:lightline = {
	\ 'colorscheme':'wombat',
	\ 'active': {
	\	'left': [ [ 'mode', 'paste' ],
	\		 [ 'readonly', 'directory', 'modified' ] ]
	\ },
	\ 'component': {
	\	'directory': '%F'
	\ },
	\ }
