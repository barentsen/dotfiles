# We execute .bashrc to avoid maintaining two files
#
# Note that .bash_profile is executed at login; .bashrc at non-login.
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
