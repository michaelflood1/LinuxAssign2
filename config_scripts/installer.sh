!#bin/env bash

#this script pulls from a pre-written list of packages and installs them using pacman

#path to downloadable content
packageList="./user_packages"

#iterate through users pre written list of packages

for package in (cat "{$packageList}" | tr "\r" " ");
	do
		pacman -S --noconfirm {$package}
	done
