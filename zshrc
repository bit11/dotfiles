#--------------------------------------------------------------------
# zsh config file
# ~/.zshrc
# Updated 15 Oct 14
# 'man zshoptions' for details
#--------------------------------------------------------------------

## History options
HISTFILE=~/.histfile
HISTSIZE=100
SAVEHIST=500
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt beep extendedglob nomatch notify

## Completions
autoload -Uz compinit
compinit
setopt completealiases					# Auto complete of aliases
setopt correct							# Set autocorrect

zstyle ':completion:*' menu select		# Arrow driven autocompletion
zstyle :compinstall filename '/home/bit11/.zshrc'
zstyle ':completion:*' completer _complete _match _approximate # Fuzzy completion matching
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

## General zsh settings
#xhost +local:root > /dev/null 2>&1

## Set coloured prompt
autoload -U colors && colors
PROMPT=$'\n'"%{$fg[red]%}██ [ %~ ] [ %T ] "$'\n'"%{$reset_color%}██ "

##  Environment variables
export EDITOR=vim
export VISUAL=vim

## Set keymaps
# vi zle
bindkey -v

# create a zkbd compatible hash to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   forward-word
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" backward-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init () {
	printf '%s' "${terminfo[smkx]}"
}
function zle-line-finish () {
printf '%s' "${terminfo[rmkx]}"
	}
	zle -N zle-line-init
	zle -N zle-line-finish
fi

# Other keymaps
bindkey \^u kill-whole-line			# Ctrl+u to delete whole line

## Aliases-----------------------------------------------------------------

# Pacman
alias pacupg='sudo pacman -Syyu'				# Sync and upgrade packages
alias pacins='sudo pacman -S'					# Install given package
alias pacuni='sudo pacman -Rns'					# Uninstall, remove unneeded dependencies, config files
alias pacaur='sudo pacman -U'					# Install .pkg.tar.xz files
alias pacorp='sudo pacman -Rns $(pacman -Qqdt)'	# Find and uninstall orphans
alias pacinf='pacman -Qi'						# Obtain info on package
alias pacmir='sudo pacman-mirrors -g'   		# Update mirror list

# AUR Manager
alias aurupg='aurman -u'						# Upgrade AUR packages
alias aurins='aurman -i'						# Install AUR packages

# Git Manager
alias gita='gitman -a'
alias gitr='gitman -r'
alias gitp='gitman -p'

# Package Cache Manager
alias paccacheu='paccacheman -u'					# Clear cache of uninstalled packages
alias paccachei='paccacheman -i'					# Clear cache of installed packages

# Misc
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                       		    # confirm before overwriting something
alias rm=' timeout 10 rm -iv --one-file-system' # Suspend rm after 5 seconds, ask for confirmation for even one file
alias xrdb='xrdb ~/.Xresources'					# Reload Xresources file
alias cal='cal -y'								# List whole year's calendar
alias makedwm='make clean && make -j4'          # Recompile dwm

#VBA
alias vba='gvbam $HOME/Documents/VisualBoyAdvance-1.7.2/"Legend of Zelda - A Link To The Past.gba"'

#Disable/enable firewall
alias stopfirewall='sudo systemctl stop iptables' 	# Stop firewall
alias startfirewall='sudo systemctl start iptables'	# Start firewall

#Disable screensaver
alias movieon='xset -dpms; xset s off && xset q && xautolock -disable'
alias movieoff='xset +dpms; xset s on && xset q && xautolock -enable'
alias soff='xset dpms force off && slock'

# Connect to Imperial Network Drive
alias umountimperial='sudo umount /media/imperial'

# Microsoft Office
#alias excel='WINEPREFIX=~/office07 wine $HOME/office07/drive_c/"Program Files"/"Microsoft Office"/Office12/EXCEL.EXE' # Open Excel
#alias word='WINEPREFIX=~/office07 wine $HOME/office07/drive_c/"Program Files"/"Microsoft Office"/Office12/WINWORD.EXE' # Open Word
#alias powerpoint='WINEPREFIX=~/office07 wine $HOME/office07/drive_c/"Program Files"/"Microsoft Office"/Office12/POWERPNT.EXE' # Open Powerpoint

## Functions-------------------------------------------------------------------

# Coloured man pages
man() {
	env LESS_TERMCAP_mb=$'\E[01;31m' \
		LESS_TERMCAP_md=$'\E[01;32;74m' \
		LESS_TERMCAP_me=$'\E[0m' \
		LESS_TERMCAP_se=$'\E[0m' \
		LESS_TERMCAP_so=$'\E[38;5;246m' \
		LESS_TERMCAP_ue=$'\E[0m' \
		LESS_TERMCAP_us=$'\E[04;38;5;146m' \
		man "$@"
}

#Combine cd and ls
cl() {
	dir=$1
	if [[ -z "$dir" ]]; then
		dir=$HOME
	fi
	if [[ -d "$dir" ]]; then
		cd "$dir"
		ls
	else
		echo "bash: cl: '$dir': Directory not found"
	fi
}

#
## File Extractor
# usage: ex <file>
ex ()
{
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xjvf $1   ;;
			*.tar.gz)    tar xzvf $1   ;;
			*.bz2)       bunzip2 $1   ;;
			*.rar)       unrar xv $1     ;;
	  		*.gz)        gunzip $1    ;;
			*.tar)       tar xvf $1    ;;
			*.tbz2)      tar xjvf $1   ;;
			*.tgz)       tar xzvf $1   ;;
			*.zip)       unzip $1     ;;
			*.Z)         uncompress $1;;
	  		*.7z)        7z xv $1      ;;
  			*)           echo "'$1' cannot be extracted via ex()" ;;
	esac
else
	echo "'$1' is not a valid file"
fi
}
