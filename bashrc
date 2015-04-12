#--------------------------------------------------------------------
# .bashrc
# ~/.bashrc
# Updated 26 Jun 14
#--------------------------------------------------------------------


if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi

xhost +local:root > /dev/null 2>&1

## Shell Options

complete -cf sudo

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth

## Shell Appearance

PS1="\n\$(if [[ \$? == 0 ]]; then echo \"\[\033[0;96m\]\"; else echo \"\[\033[0;31m\]\"; fi)\342\226\210\342\226\210 [ \W ] [ \t ]\n\[\033[0m\]\342\226\210\342\226\210 "

##  Environment variables
export EDITOR=vim
export VISUAL=vim

## Aliases

#Pacman
alias pacupg='sudo pacman -Syyu'				# Sync and upgrade packages
alias pacins='sudo pacman -S'					# Install given package
alias pacuni='sudo pacman -Rns'					# Uninstall, remove unneeded dependencies, config files
alias pacaur='sudo pacman -U *.pkg.tar.xz'		# Install .pkg files
alias pacorp='sudo pacman -Rns $(pacman -Qqdt)'	# Find and uninstall orphans
alias makepkg='makepkg -scir'					# Build AUR packages
alias pacinf='pacman -Qi'						# Obtain info on package
alias pacmir='sudo pacman-mirrors -g'   		# Update mirror list

#Misc
alias suspend='systemctl suspend' 		# Suspend system
alias hibernate='systemctl hibernate'   # Hibernate system
alias reboot='systemctl reboot'			# Reboot system
alias poweroff='systemctl poweroff'		# Shut down system
alias scrot='scrot -s /media/data/Pictures/Screenshots/%Y-%m-%d-%T-screenshot.png' # Screenshot region
alias standby='xset dpms force standby' # Puts screen on standby
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                       		    # confirm before overwriting something
alias df='df -h'                          		# human-readable sizes
alias free='free -m'                      		# show sizes in MB
alias rm=' timeout 5 rm -iv --one-file-system'  # Suspend rm after 5 seconds, ask for confirmation for even one file
alias screenoff='xset dpms force off'			# Switch off screen
alias xrdb='xrdb ~/.Xresources'					# Reload Xresources file
alias matlab='wmname LG3D && matlab'			# Change wmname to prevent java issues with matlab
alias makedwm='make clean && make -j4'			# Recompile dwm

#Microsoft Office
alias excel='WINEPREFIX=~/.wineoffice07 wine $HOME/.wineoffice07/drive_c/"Program Files"/"Microsoft Office"/Office12/EXCEL.EXE' # Open Excel
alias word='WINEPREFIX=~/.wineoffice07 wine $HOME/.wineoffice07/drive_c/"Program Files"/"Microsoft Office"/Office12/WINWORD.EXE' # Open Word
alias powerpoint='WINEPREFIX=~/.wineoffice07 wine $HOME/.wineoffice07/drive_c/"Program Files"/"Microsoft Office"/Office12/POWERPNT.EXE' # Open Powerpoint

#VBA
alias vba='gvbam $HOME/Documents/VisualBoyAdvance-1.7.2/"Mario & Luigi - Superstar Saga.gba"'

#Disable/enable firewall
alias stopfirewall='sudo systemctl stop iptables' 	# Stop firewall
alias startfirewall='sudo systemctl start iptables'	# Start firewall

#Disable screensaver
alias movieon='xset -dpms; xset s off && xset q && xautolock -disable'
alias movieoff='xset +dpms; xset s on && xset q && xautolock -enable'

# Connect to Imperial Network Drive
alias mountimperial='$HOME/mountimperial'
alias umountimperial='sudo umount /media/imperial'

# Base16 Shell
BASE16_SHELL="$HOME/dotfiles/colours/base16-shell/base16-railscasts.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

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

## Scripts

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

## Note taker
# Usage: notes <arg>
notes () {

    # Create file if doesn't exist
    if [[ ! -f $HOME/.notes ]]; then
        touch "$HOME/.notes"
    fi
    
    #Show full list
    if ! (($#)); then
        cat "$HOME/.notes"
	
    #Clear list
    elif [[ "$1" == "-c" ]]; then
        > "$HOME/.notes"
	
    #Remove line
    elif [[ "$1" == "-r" ]]; then
        nl -b a "$HOME/.notes"
        printf "\n"
        read -p "Type a number to remove: " number
        sed -i "$number d" "$HOME/.notes"
    else
    
    #Append to file
        printf "%s\n" "$*" >> "$HOME/.notes"
    fi
}

## To-do list
#Usage: todo <arg>
todo() {

    #Create file if doesn't exist
    if [[ ! -f $HOME/.todo ]]; then
        touch "$HOME/.todo"
    fi
    
    #Show full list	
    if ! (($#)); then
        cat "$HOME/.todo"
	
    #Show full numbered list
    elif [[ "$1" == "-l" ]]; then
        nl -b a "$HOME/.todo"
	
    #Clear list
    elif [[ "$1" == "-c" ]]; then
        > $HOME/.todo
    
    #Remove line
    elif [[ "$1" == "-r" ]]; then
        nl -b a "$HOME/.todo"
        printf "\n"
        read -p "Type a number to remove: " number
        sed -i "$number d" $HOME/.todo
	
    #Append to end of file
    else
        printf "%s\n" "$*" >> "$HOME/.todo"
    fi
}

## Cache Cleaner
# Cache cleaner for all uninstalled packages
# Usage: paccacheu
paccacheu() {
   if (paccache -duvk0 | grep -o "no candidate packages") 1>/dev/null; then
	echo "No packages for pruning"
	return
    else 
    
	#List all possible candidates for pruning
        paccache -duvk0
        read -p "Delete all packages? (y/n)" status
	    if [[ "$status" == "y" ]]; then
	
	#Remove above list
	        paccache -ruvk0
	       	return
	    else
	    	return 
	    fi
    fi
}
        
# Cache cleaner for all installed packages, keeping 4 packages in cache
# Usage: paccachei
paccachei() {
   if (paccache -dvk4 | grep -o "no candidate packages") 1>/dev/null; then
	echo "No packages for pruning"
	return
    else 
    
	#List all possible candidates for pruning
        paccache -dvk4
        read -p "Delete all packages? (y/n)" status
	    if [[ "$status" == "y" ]]; then
	    
	#Remove above list
	        paccache -rvk4
	       	return
	    else
	    	return 
	    fi
    fi
}
    
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


