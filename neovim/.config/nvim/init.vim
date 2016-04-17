"""""""""""""""""""""""""""""""""""""""""""""""""
" Make sure some XDG_*_HOME variables are set
"""""""""""""""""""""""""""""""""""""""""""""""""
if empty($XDG_CACHE_HOME)
	let $XDG_CACHE_HOME = $HOME . '/.cache'
endif
if empty($XDG_CONFIG_HOME)
	let $XDG_CONFIG_HOME = $HOME . '/.config'
endif
if empty($XDG_DATA_HOME)
	let $XDG_DATA_HOME = $HOME . '/.local/share'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin management with vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""
source $XDG_CONFIG_HOME/nvim/plug.vim

"""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
"""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
colorscheme distinguished
set gdefault " The substitution flag g is always on
set nobackup  " Don't use backupfiles
set noswapfile  " Disable swap files
set spelllang=en
set undolevels=100  " Max number of changes that can be undone
set undoreload=100  " Max number of lines to save for undo on a buffer reload

"""""""""""""""""""""""""""""""""""""""""""""""""
" Autocmd settings
"""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWritePre * :call StripTrailingWhitespace()

"""""""""""""""""""""""""""""""""""""""""""""""""
" Keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""
" Set <leader>
let mapleader=','
let g:mapleader=','

" Don't move cursor when repeating last command with '.'
nmap . .`[

" Easy use of tabs
nmap <leader>tc :tabclose<cr>
nmap <leader>tn :tabnext<cr>
nmap <leader>to :tabopen<cr>
nmap <leader>tp :tabprevious<cr>

" Toggle folds
noremap <space> za

" Toggle pastemode
nmap <silent><leader>p :set paste!<BAR>:silent set paste?<cr>

" Toggle NERDTree
nmap <silent><leader>b :NERDTreeToggle<CR>

" Avoid accidental hits of <F1> while aiming for <ESC>
noremap <F1> <Esc>

" Quick close of VIm
nmap <leader>q :quit<CR>

" Quick save of VIm
nmap <leader>w :write<CR>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <leader>nc <C-w>v<C-w>l

" Clears the search register
nmap <silent><leader>/ :nohlsearch<CR>

" Jump to matching pairs easily, with Tab
nnoremap <Tab> %

" Toggle 'set list'
nmap <silent><leader>l :set list!<CR>

" Easy access to init.vim
nmap <silent><leader>e :e $XDG_CONFIG_HOME/nvim/init.vim<CR>

" Don't use ex-mode
nnoremap Q gq

" Open terminal
nmap <F12> :below split +te<CR>

" Remap
tnoremap <ESC> <C-\><C-n>

"""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:flake8_show_in_gutter=1
let g:gist_detect_filetype=1
let g:gist_show_privates=1
let g:gist_post_private=1
let g:netrw_home=$XDG_CACHE_HOME . '/nvim'
let g:vim_markdown_folding_disabled=1
let g:markdown_folding_disabled=1
let g:NERDChristmasTree=1
let g:NERDTreeBookmarksFIle=$XDG_DATA_HOME . '/nvim/NERDTreeBookmarks'
let g:NERDTreeHighlightCursorline=0
let g:NERDTreeHijackNetrw=1
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeQuitOnOpen=1

"""""""""""""""""""""""""""""""""""""""""""""""""
" Printer settings
"""""""""""""""""""""""""""""""""""""""""""""""""
set printdevice=PDF-Printer
set printoptions=number:n,syntax:n

"""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax settings
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:python_hightlight_all=1

"""""""""""""""""""""""""""""""""""""""""""""""""
" Text editing settings
"""""""""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=4
set softtabstop=4
set tabstop=4
set textwidth=79

"""""""""""""""""""""""""""""""""""""""""""""""""
" UI settings
"""""""""""""""""""""""""""""""""""""""""""""""""
set cmdheight=1
set colorcolumn=+1
set cursorline
set foldcolumn=2
set listchars=tab:\│\ ,trail:·,extends:»,precedes:«,eol:¶,nbsp:█
set number
set ruler
set scrolloff=5  " Keep n lines above/under cursor
set sidescrolloff=5  " Keep n columns left/right of cursor
set shortmess+=I " Disable version information when starting with an empty file
set showcmd
set showmode
set title
set updatetime=250

"""""""""""""""""""""""""""""""""""""""""""""""""
" Wildmenu settings
"""""""""""""""""""""""""""""""""""""""""""""""""
set wildignore+=*.flac,*.ogg,*.mp3,*.wav,*.wma
set wildignore+=*~,*.backup,*.bak,*.swp
set wildignore+=~/.bash_history
set wildignore+=*.db,*.sqlite
set wildignore+=*.bmp,*.gif,*.jpe,*.jpeg,*.jpg,*.png,*.psd,*.xcf,*.xpm
set wildignore+=matlab_crash_dump*
set wildignore+=*.dat,*.directory,*.lock,*.nb,*.torrent,*.DS_Store
set wildignore+=_MACOSX,~/.MP3Diags.dat,~/.esd_auth,~/.face
set wildignore+=*.o,*.obj,*.pyc,*.pyo
set wildignore+=octave-core,~/octave_hist
set wildignore+=*.avi,*.flv,*.mkv,*.mp4,*.mpeg,*.mpg,*.ogv,*.wmv
set wildignore+=~/.zcompdump,~/.zsh_history
set wildignore+=~/.ICEauthority,~/.Xauthority

"""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
"""""""""""""""""""""""""""""""""""""""""""""""""
function! StripTrailingWhitespace()
	" Strip trailing whitespace

	" Don't run on some filetypes
	if &ft =~ 'asciidoc\|markdown\|mkd'
		return
	endif

	" Save cursor position
	let line = line('.')
	let col = col('.')

	" Remove trailing whitespace
	%s:\s\+$::e

	" Restore cursor position
	call cursor(line, col)
endfunction
