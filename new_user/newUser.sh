#!/bin/env bash

# This script assists with user creation in all of it's facets:
# username
# password
# etc information copying
# group addition
#


# check that script is run in sudo or from root

if [[ "$EUID" -ne 0 ]];
	then
	echo "ensure to run as root or with 'sudo'"
	exit 1
fi

#parse options with getopts and proceed with a different method for each
while getopts ":u:g:s:h" opt;
do
	case $opt in
		u)
			if [[ -z "$u" ]] ||  [[ -d ~/"${u} ]] ;
				do
				echo "this user is already created or 
				additional argument require see
				-u["username"]
				exit 1
			else
				useradd -d ~/"${u}"
				echo " add a password for the user"
				passwd "${u}"

			fi

			;;
		g)
			if [[ -z "$g" ]];
			do
				echo " additional argument required see
				-g["group"]"
				exit 1
			fi

			;;
		s)
			if [[ -z "$s" ]];
			do
				echo "additional argument required see
				-s[""]"
			fi

			;;
		h)
			echo "this script requires root or sudo privelages.
			options -u -g -s ((username, groups, shell)) require
			and additional [argument] 
			-h for assistance"

			;;
		\?) 
			echo "useage:
			sudo mandatory -u["username"] -g["grouptoadduserto"] -s["usersprefferedshell"] -h"

			;;
	esac
