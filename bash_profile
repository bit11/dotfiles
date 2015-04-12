#----------------------------------------------------
# bash_profile
# ~/.bash_profile
# Last updated 26 Jun 14
#----------------------------------------------------

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
