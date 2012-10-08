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
