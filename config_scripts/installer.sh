#!/bin/env bash
echo "starting installer script"
#this script pulls from a pre-written list of packages and installs them using pacman
usrHomeDir=$(getent passwd $SUDO_USER | cut -d: -f6)
#path to downloadable content
packageList=$(cat ./user_packages)
echo "$packageList"
#iterate through users pre written list of packages
if [[ -f ${usrHomeDir}/installallowed ]]; then



	for line in ${packageList};
	do
		pacman -S --noconfirm ${line} # installs and forces through dialog for each package
		echo "installed ${line}"
		
	done
	
fi
