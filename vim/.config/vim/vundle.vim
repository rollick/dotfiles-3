" Set up bundles using Vundle

" Install Vundle
let vundle_installed=1

" Bootstrap vundle
if !filereadable(expand($XDG_CACHE_HOME . '/vim/bundles/vundle/README.md'))
	let vundle_installed=0
	echo 'Installing Vundle'
	echo ''
	silent !mkdir -p $XDG_CACHE_HOME/vim/bundles
	silent !git clone https://github.com/gmarik/Vundle.vim $XDG_CACHE_HOME/vim/bundles/vundle
endif

" Set up Vundle
set nocompatible
filetype off
set rtp+=$XDG_CACHE_HOME/vim/bundles/vundle/
call vundle#begin($XDG_CACHE_HOME . '/vim/bundles')

" Let Vundle manage itself

Plugin 'VundleVim/Vundle.vim', {'name': 'vundle'}
source $XDG_CONFIG_HOME/vim/vundlelist.vim

call vundle#end()

filetype plugin indent on

if vundle_installed == 0
	echo 'Installing Plugins...'
	echo ''
	:PluginInstall
endif
