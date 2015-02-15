# Links configuration files in my homedir
PWD=$(shell pwd)

install: install-tmux install-zsh install-powerline

install-tmux:
	ln -sf "$(PWD)/tmux/tmux.conf" ~/.tmux.conf

install-zsh:
	# Note that zsh won't be fully installed until it is run for the first time
	ln -sf "$(PWD)/zsh/zshrc" ~/.zshrc
	ln -sf "$(PWD)/zsh/zgen.zsh" ~/.zgen.zsh
	ln -sf "$(PWD)/zsh/zshenv" ~/.zshenv

install-powerline:
	pip install powerline-status
	mkdir -p ~/.config/powerline
	ln -sf "$(PWD)/powerline/config.json" ~/.config/powerline/config.json
	mkdir -p ~/.config/powerline/themes/tmux
	ln -sf "$(PWD)/powerline/themes-tmux.json" ~/.config/powerline/themes/tmux/default.json
