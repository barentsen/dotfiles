# Geert's custom Bash configuration
# Inspired by https://github.com/mathiasbynens/dotfiles

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Detect the OS
export OS=$(uname)
export TERM='xterm-256color'

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,aliases,apparix,extra}; do
	[ -r "$file" ] && source "$file"
done



#########
# $PATH
#########
colonise() {
	cat $1 | tr "\n" ":"
}
# Path settings are stored in ~/.path and ~/.path_local; one line per entry
for file in ~/.{path,path_local}; do
	[ -r "$file" ] && export PATH=`colonise $file`:$PATH
done
unset file


###################
# MACHINE-SPECIFIC
###################

# Where is the Anaconda Python distribution?
export PYTHONDIR="/home/gb/bin/anaconda" 

# Options specific to Herts
if [[ $HOSTNAME =~ .*herts.* ]]; then
	# Printers
    alias prnt='lpr -Plj2' # Print in black/white
    alias prntc='lpr -Pljc3' # Print in colour
    # Others
    alias gaia='/soft/star-namaka-64bit/bin/gaia/gaia_standalone.csh'
fi

if [[ $HOSTNAME =~ .*geertbook.* ]]; then
	export PYTHONDIR="/Library/Frameworks/EPD64.framework/Versions/7.3"
	export PYTHONDIR2="$HOME/bin/python"
	alias subl="/Applications/Sublime\ Text\ 2.app/Contents/MacOS/Sublime\ Text\ 2"
fi


#########
# PYTHON
#########
if [ ! -z "$PYTHONDIR" ]; then
	export PATH="$PYTHONDIR/bin":$PATH
	export PYTHONPATH="$PYTHONDIR/lib/python2.7/site-packages/:$HOME/bin/python/lib/python2.7/site-packages/"
	export PYTHONPATH="$PYTHONPATH:$HOME/dev/iphas-dr2:$HOME/dev/pygaps:$HOME/dev/meteorpy:$HOME/dev/meteor-flux"
	export PYTHONHOME=$PYTHONDIR
fi


################
# SHELL OPTIONS
################

# We prefer vim
export EDITOR=vim
# Enable insane vi powers in the shell
set -o vi
set editing-mode vi
set keymap vi

# Pretty ls colours
export LS_COLORS='rs=0:di=00;34:ln=00;36:mh=00:pi=40;33:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.tlz=00;31:*.txz=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.dz=00;31:*.gz=00;31:*.lz=00;31:*.xz=00;31:*.bz2=00;31:*.tbz=00;31:*.tbz2=00;31:*.bz=00;31:*.tz=00;31:*.deb=00;31:*.rpm=00;31:*.jar=00;31:*.war=00;31:*.ear=00;31:*.sar=00;31:*.rar=00;31:*.ace=00;31:*.zoo=00;31:*.cpio=00;31:*.7z=00;31:*.rz=00;31:*.jpg=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.svg=00;35:*.svgz=00;35:*.mng=00;35:*.pcx=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.m2v=00;35:*.mkv=00;35:*.ogm=00;35:*.mp4=00;35:*.m4v=00;35:*.mp4v=00;35:*.vob=00;35:*.qt=00;35:*.nuv=00;35:*.wmv=00;35:*.asf=00;35:*.rm=00;35:*.rmvb=00;35:*.flc=00;35:*.avi=00;35:*.fli=00;35:*.flv=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.yuv=00;35:*.cgm=00;35:*.emf=00;35:*.axv=00;35:*.anx=00;35:*.ogv=00;35:*.ogx=00;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:*.pdf=00;33:*.ps=00;33:*.ps.gz=00;33:*.txt=00;33:*.patch=00;33:*.diff=00;33:*.log=00;33:*.tex=00;33:*.xls=00;33:*.xlsx=00;33:*.ppt=00;33:*.pptx=00;33:*.rtf=00;33:*.doc=00;33:*.docx=00;33:*.odt=00;33:*.ods=00;33:*.odp=00;33:*.xml=00;33:*.epub=00;33:*.abw=00;33:*.html=00;33:*.wpd=00;33:';

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"
[ -x /usr/bin/lesspipe.sh ] && eval "$(lesspipe.sh)"

# Don't put duplicate lines or lines starting with space in the history
export HISTCONTROL=ignoreboth

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize


# More machine-specific
if [[ $HOSTNAME =~ .*(uhppc|gvm|flux|ec2).* ]]; then
    # Start ssh-agent
    if [ ! $SSH_AGENT_PID ]; then
        eval `ssh-agent` > /dev/null
    fi;

    # System status welcome message
    CPU=`top -bn 1 | cut -d',' -f4 | awk 'BEGIN{FS="[ \t%]+"} NR==3{ print 100-$2 }'`
    LOAD=`uptime | awk -F, '{print $(NF)}'`
    DISK=`df -lh 2> /dev/null | awk '{if ($6 == "/") { print $5 }}' | head -n1`
    RAM=`free -m | grep Mem 2> /dev/null`
    RAMNOW=`echo $RAM | cut -f3 -d' '`
    RAMTOT=`echo $RAM | cut -f2 -d' '`
    echo cpu $CPU%, load $LOAD, mem $(echo "scale = 1; $RAMNOW/$RAMTOT*100" | bc)%, disk $DISK
fi
