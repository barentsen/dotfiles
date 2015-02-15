# Links configuration files in my homedir
PWD=$(shell pwd)

install: update-submodules install-tmux install-zsh \
	     install-powerline install-vim install-fonts

update-submodules:
	# some features, e.g. vim pathogen and powerline fonts, are git submodules
	git submodule init
	git submodule update

install-tmux:
	ln -sf "$(PWD)/tmux/tmux.conf" ~/.tmux.conf

install-zsh:
	# Note that zsh won't be fully installed until it is run for 
	# the first time, because we use zgen to add features
	ln -sf "$(PWD)/path" ~/.zsh_path
	ln -sf "$(PWD)/aliases" ~/.zsh_aliases
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

install-fonts:
	# The powerline fonts are necessary to make funny characters appear pretty
	$(PWD)/powerline/fonts/install.sh
