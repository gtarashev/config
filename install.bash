#!/usr/bin/env bash
# Install script for my config, installs dependencies, 
# makes symlinks in $HOME/.config and makes software
#
# ====================

# *** functions ***
makeSymLink() {
	echo ''

	# make sure config exists
	echo -n 'creating $HOME/.config... '
	mkdir -p $HOME/.config
	echo 'DONE'

	# loop through directories and create links
	echo 'creating sym links:'
	for i in $dir/dotfiles/config/*; do
		local dirname=${i##*/}
		echo -n "creating sym link for $dirname... "
		ln -fLs $dir/dotfiles/config/$dirname $HOME/.config/ && echo 'DONE' || echo "error when creating sym link for $dirname"
	done

	echo ''
	echo 'setting up special sym links:'
	# create special sym links
	echo -n 'setting up xinitrc... '
	ln -fLs $dir/dotfiles/xinitrc $HOME/.xinitrc && echo 'DONE' || echo 'FAILED'
	echo -n 'setting up bashrc... '
	ln -fLs $dir/dotfiles/bashrc $HOME/.bashrc && echo 'DONE' || echo 'FAILED'
	echo -n 'setting up zshrc... '
	echo "source $HOME/.config/zsh/zshrc" >> $HOME/.zshrc && echo 'DONE' || echo 'FAILED'

	echo 'setting up ~/scripts'
	ln -fLs $dir/scripts $HOME
}

cargoInstall() {
	# rustup
	echo 'installing the rust toolchain...'
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh || { echo 'failed to set up the rust toolchain. exiting.'; return; }

	# other rust tools
	echo 'toolchain setup successful, installing programs'
	xargs -r -a $dir/cargo-install cargo install 
}

makeDwm() {
	echo 'TODO'
}

# *** main ***
main() {
	local varresponse=''

	read -p 'would you like to setup sym links? [Y/n]: ' varresponse
	echo ''
	if [[ -z $varresponse || $varresponse == [Yy] ]]; then
		makeSymLink
	fi

	read -p 'would you like to install cargo (rustup) and other rust programs? [Y/n]: ' varresponse
	if [[ -z $varresponse || $varresponse == [Yy] ]]; then
		cargoInstall
	fi
}

# get current wd
dir=$(pwd)

main
