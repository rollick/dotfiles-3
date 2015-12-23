" Bootstrap vim-plug
if empty(glob($XDG_CONFIG_HOME . '/nvim/autoload/plug.vim'))
	silent !curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin($XDG_DATA_HOME . '/nvim/plugged')
	" Dependencies for other plugins
	Plug 'godlygeek/tabular'

	" Plugins which are not dependencies
	Plug 'lastpos.vim'
	Plug 'python_fold', {'for': 'python'}

	Plug 'Lokaltog/vim-distinguished'
	Plug 'Matt-Deacalion/vim-systemd-syntax'
	Plug 'PotatoesMaster/i3-vim-syntax'
	Plug 'airblade/vim-gitgutter'
	Plug 'jiangmiao/auto-pairs'
	Plug 'mitsuhiko/vim-python-combined', {'for': 'python'}
	Plug 'mitsuhiko/vim-rst', {'for': 'rst'}
	Plug 'nvie/vim-flake8', {'for': 'python'}
	Plug 'plasticboy/vim-markdown', {'for': 'mkd'}
	Plug 'scrooloose/nerdtree'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-surround'

	" Load always last
	Plug 'bling/vim-airline'
call plug#end()
