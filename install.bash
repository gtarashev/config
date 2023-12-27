#!/bin/bash
# Install script for my config, installs dependencies, 
# makes symlinks in ~/.config and makes software (`st` and 
# `dwm` so far)
#
# ====================
varresponse=""

while true; do
    read -p "Would you like to setup sym links? [Y/n]: " varresponse

    if [[ -z "$varresponse" || "$varresponse" == [Yy] ]]; then
	echo ""
	# make sure config exists
	echo -n "Creating ~/.config... "
	mkdir -p ~/.config
	echo "DONE"

	# get current wd 
	dir=`pwd`
	# loop through directories and create links
	echo "Creating Sym Links:"
	for i in ./dotfiles/config/*; do
	    dirname="${i##*/}"
	    echo -n "Creating sym link for $dirname... "
	    ln -fLs $dir/dotfiles/config/$dirname ~/.config/$dirname
	    echo DONE
	done

	echo ""
	echo "Setting up special sym links:"
	# create special sym links
	echo -n "Setting up xinitrc... "
	ln -fLs $dir/dotfiles/xinitrc ~/.xinitrc && echo "DONE" || echo "FAILED"
	echo -n "Setting up bashrc... "
	ln -fLs $dir/dotfiles/bashrc ~/.bashrc && echo "DONE" || echo "FAILED"
	echo -n "Setting up zshrc... "
	echo "source ~/.config/zsh/zshrc" >> ~/.zshrc && echo "DONE" || echo "FAILED"

	break

    elif [[ "$varresponse" == [Nn] ]]; then
	echo "No"
	break
    else
	echo "Incorrect Choice, Please Try Again."
    fi
done
