#!/bin/env bash

#this script manages the actions of both the installation.sh script as well as the directoryCreation.sh script

#ensure sudo used on call

if [ "$EUID" -ne 0 ];
	then
	echo "run as root, or use 'sudo'"
	exit 1
fi

#getopts is used to parse optional arguments and to proceed with either a script call or messages to the user assisting with functionality of script.
while getopts ":idh" opt; # shows three arguments are possible. # the colon prefix is to stop error messages
do
	case $opt in
		i)
		  ./installer.sh
		  ;;
		d)
		  ./directoryCreation.sh
		  ;;
		h)
		  echo "this script requires root or sudo privelage
		  option -i will run the script required to install 
		  packages for the computer
		  option -d will clone the desired tree and create 
		  symlinks to the cloned directories "
		  ;;

		\?) #invalid option attempted
			echo "useage:
			sudo mandatory 'script path' [options] -i,-d,-h"
			;;
	esac
done
		




