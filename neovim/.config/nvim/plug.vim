" Bootstrap vim-plug
if empty(glob($XDG_CONFIG_HOME . '/nvim/autoload/plug.vim'))
	silent !curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin($XDG_DATA_HOME . '/nvim/plugged')

Plug 'godlygeek/tabular'
Plug 'lastpos.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Lokaltog/vim-distinguished'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'airblade/vim-gitgutter'
Plug 'mitsuhiko/vim-rst'
Plug 'nvie/vim-flake8'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'yegappan/mru'
Plug 'bling/vim-airline'
Plug 'indentpython.vim'
call plug#end()
