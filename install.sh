#!/bin/bash
# This script will install the configuration files into the relevant places

# Create a backup dir to copy the existing dotfiles into
if [ ! -r backup ]; then
	echo "Creating backup/ directory"
	mkdir backup
fi

# Install dotfiles in the homedir
for file in .{tcshrc,bashrc,bash_profile,bash_prompt,path,aliases,apparix,extra}; do
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
	echo "~/.vim already exists, not creating a symbolic link."
else
	ln -s ~/dev/dotfiles/vim ~/.vim
	ln -s ~/dev/dotfiles/vim/vimrc ~/.vimrc
fi

# Sublime Text
if [ -r ~/.config/sublime-text-2/Packages/User ]; then
	for file in Preferences SublimeLinter HTML; do
		ln -s ~/dev/dotfiles/sublime/$file.sublime-settings ~/.config/sublime-text-2/Packages/User/$file.sublime-settings
	done
fi
