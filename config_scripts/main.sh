#!/bin/env bash

#this script manages the actions of both the installation.sh script as well as the directoryCreation.sh script

#ensure sudo used on call

if [ "$EUID" -ne 0 ];
	then
	echo "run as root, or use 'sudo'"
	exit 1
fi
usrHomeDir=$(getent passwd $SUDO_USER | cut -d: -f6)
echo "starting main"
pwd
#getopts is used to parse optional arguments and to proceed with either a script call or messages to the user assisting with functionality of script.
while getopts ":idh" opt; # shows three arguments are possible. # the colon prefix is to stop error messages
do
	case $opt in
		i)
		  touch ${usrHomeDir}/installallowed #creates a security file so only main.sh can run scripts
		  echo "file touched"
		  ./installer.sh #calls the installation script
		  rm ${usrHomeDir}/installallowed
		  echo "file removed" #removes security file
		  ;;
		d) #basically the same block as above
		   touch ${usrHomeDir}/creationAllowed 
		  ./directoryCreation.sh
		  rm ${usrHomeDir}/creationAllowed
		  ;;
		h) # tells the user detailed info about using the script
		  echo "this script requires root or sudo privelage
		  option -i will run the script required to install 
		  packages for the computer
		  option -d will clone the desired tree and create 
		  symlinks to the cloned directories "
		  ;;

		\?) #invalid option attempted # a bad syntactical call from a user is responded to with correct usage
			echo "useage:
			sudo mandatory 'script path' [options] -i,-d,-h"
			;;
	esac
done
		




