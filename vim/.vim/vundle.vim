" Set up bundles using Vundle

" Install Vundle
let vundle_installed=1

" Bootstrap vundle
if !filereadable(expand('~/.vim/bundle/vundle/README.md'))
	let vundle_installed=0
	echo 'Installing Vundle'
	echo ''
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/vundle
endif

" Set up Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" Let Vundle manage itself

Plugin 'gmarik/Vundle.vim', {'name': 'vundle'}
source ~/.vim/vundlelist.vim

call vundle#end()

filetype plugin indent on

if vundle_installed == 0
	echo 'Installing Plugins...'
	echo ''
	:PluginInstall
endif
