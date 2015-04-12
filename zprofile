#----------------------------------------------------
# zsh zprofile 
# ~/.zprofile
# Last updated 26 Jun 14
#----------------------------------------------------

[[ -f ~/.zshrc ]] && . ~/.zshrc

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

#export GPG_TTY=$(tty)
#export GPG_AGENT_INFO=""
