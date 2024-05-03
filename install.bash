#!/usr/bin/env bash
# Install script for my config, installs dependencies, 
# makes symlinks in ~/.config and makes software
#
# ====================
varresponse=""

while true; do
    read -p 'Would you like to setup sym links? [Y/n]: ' varresponse

    if [[ -z $varresponse || $varresponse == [Yy] ]]; then
		echo ''

		# make sure config exists
		echo -n 'Creating ~/.config... '
		mkdir -p ~/.config
		echo 'DONE'

		# get current wd 
		dir=$(pwd)
		# loop through directories and create links
		echo 'Creating Sym Links:'
		for i in $dir/dotfiles/config/*; do
			dirname=${i##*/}
			echo -n "Creating sym link for $dirname... "
			ln -fLs $dir/dotfiles/config/$dirname $HOME/.config/ && echo 'DONE' || echo "Error when creating sym link for $dirname"
		done

		echo ''
		echo 'Setting up special sym links:'
		# create special sym links
		echo -n 'Setting up xinitrc... '
		ln -fLs $dir/dotfiles/xinitrc ~/.xinitrc && echo 'DONE' || echo 'FAILED'
		echo -n 'Setting up bashrc... '
		ln -fLs $dir/dotfiles/bashrc ~/.bashrc && echo 'DONE' || echo 'FAILED'
		echo -n 'Setting up zshrc... '
		echo "source $HOME/.config/zsh/zshrc" >> ~/.zshrc && echo 'ONE' || { echo 'FAILED'; break; }

		break

    elif [[ $varresponse == [Nn] ]]; then
		break
    else
		echo 'Incorrect Choice, Please Try Again.'
    fi
done
