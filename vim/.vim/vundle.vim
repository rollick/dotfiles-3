" Set up bundles using Vundle

" Install Vundle
let vundle_installed=1

" Bootstrap vundle
if !filereadable(expand('~/.vim/bundle/vundle/README.md'))
	let vundle_installed=0
	echo 'Installing Vundle'
	echo ''
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
endif

" Set up Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage itself

Plugin 'gmarik/vundle'
source ~/.vim/vundlelist.vim

if vundle_installed == 0
	echo 'Installing Plugins...'
	echo ''
	:BundleInstall
endif
