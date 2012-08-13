# Geert's custom Bash configuration
# Inspired by https://github.com/mathiasbynens/dotfiles
#
# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && source "$file"
done



# Set the $PATH
colonise() {
	cat $1 | tr "\n" ":"
}

for file in ~/.{path,path_local}; do
	[ -r "$file" ] && export PATH=`colonise $file`:$PATH
done




# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell



# Cleanup
unset file