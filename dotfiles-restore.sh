#!/bin/bash
#---------------------------------------
# Install script for restoring relevant 
# dotfiles to correct locations.
# Last updated 12 Apr 2015
#---------------------------------------

set -e

# zsh stuff
git clone --recursive https://github.com/bit11/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
      ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Vundle and filetype specific settings
git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
cd vim/ftplugin
for file in $(ls); do
    ln -s $file $HOME/.vim/ftplugin/$file
done

# Rest of the other dotfiles
files="bash_profile bashrc gtkrc-2.0 vimrc xinitrc Xresources"
for file in $files; do
    ln -s $file $HOME/.$file
done

cfiles="redshift" 
for file in $cfiles; do
    ln -s $file $HOME/.config/$file
done

cfolders="dunst ranger gtk-3.0 zathura"
for folder in $cfolders; do
    cd folder
    for file in $(ls); do
        ln -s $folder/$file $HOME/.config/$folder/$file
    done
    cd ../
done

folders="ncmpcpp"
for folder in $folders; do
    cd folder
    for file in $(ls); do
        ln -s $folder/$file $HOME/.$folder/$file
    done
    cd ../
done

