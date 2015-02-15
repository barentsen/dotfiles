# Links configuration files from the homedir.
# 
# Usage:
# make all


PWD=$(shell pwd)

install: install-tmux install-zsh \
         install-powerline install-vim

submodules: update-submodules install-fonts

all: submodules install

install-tmux:
	ln -sf "$(PWD)/tmux/tmux.conf" ~/.tmux.conf

install-zsh:
	# Note that zsh won't be fully installed until it is run for 
	# the first time, because we use zgen to add features
	ln -sf "$(PWD)/local" ~/.zsh_local
	ln -sf "$(PWD)/zsh/path" ~/.zsh_path
	ln -sf "$(PWD)/zsh/aliases" ~/.zsh_aliases
	ln -sf "$(PWD)/zsh/zgen.zsh" ~/.zgen.zsh
	ln -sf "$(PWD)/zsh/zshenv" ~/.zshenv
	ln -sf "$(PWD)/zsh/zshrc" ~/.zshrc

install-powerline:
	pip install powerline-status
	mkdir -p ~/.config/powerline
	ln -sf "$(PWD)/powerline/config.json" ~/.config/powerline/config.json
	mkdir -p ~/.config/powerline/themes/tmux
	ln -sf "$(PWD)/powerline/themes-tmux.json" ~/.config/powerline/themes/tmux/default.json

install-vim:
	ln -sf "$(PWD)/vim" ~/.vim
	ln -sf ~/.vim/vimrc ~/.vimrc

update-submodules:
	# some features, e.g. vim pathogen and powerline fonts, are git submodules
	git submodule init
	git submodule update

install-fonts: powerline/fonts/install.sh
	# The powerline fonts are necessary to make funny characters appear pretty
	$(PWD)/powerline/fonts/install.sh
