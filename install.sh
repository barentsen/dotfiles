#!/bin/bash
# This script will install the configuration files into the relevant places

# Make sure our dependencies are pulled in
git submodule init
git submodule update

# Create a backup dir to copy the existing dotfiles into
if [ ! -r backup ]; then
	echo "Creating backup/ directory"
	mkdir backup
fi

# Install dotfiles in the homedir
for file in .{tcshrc,bashrc,bash_profile,bash_prompt,path,aliases,apparix,tmux.conf,extra}; do
	if [ -r "$file" ]; then

		# If a (non-symlink) file exists, backup and remove
		if [ -r ~/$file ]; then
			echo "Backup up existing ~/$file to backup/$file"
			mv ~/$file backup/
		fi
		
		# Copy versioned file to homedir
		echo "Copying $file to ~"
		cp $file ~/$file
	fi
done
unset file

# VIM
if [ -r ~/.vim ]; then
	echo "Skipped linking ~/.vim (target already exists)"
else
	ln -s $PWD/vim ~/.vim
	ln -s ~/.vim/vimrc ~/.vimrc
fi

# Sublime Text
STCONFIG="$HOME/.config/sublime-text-3/Packages/User"
if [ -r $STCONFIG ]; then
	for FILE in Preferences SublimeLinter HTML; do
		TARGET="$STCONFIG/$FILE.sublime-settings"
		if [ -r $TARGET ]; then
			echo "Skipped linking $TARGET (target already exists)"
		else
			ln -s $PWD/sublime/$FILE.sublime-settings $TARGET
		fi
	done
fi
