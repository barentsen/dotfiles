# Links configuration files in my homedir
PWD=$(shell pwd)

install: install-tmux install-zsh

install-tmux:
	ln -sf "$(PWD)/tmux/tmux.conf" ~/.tmux.conf

install-zsh:
	ln -sf "$(PWD)/zsh/zshrc" ~/.zshrc
	ln -sf "$(PWD)/zsh/zgen.zsh" ~/.zgen.zsh
	ln -sf "$(PWD)/zsh/zshenv" ~/.zshenv
	#zsh -i -c exit
