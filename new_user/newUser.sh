#!/bin/bash

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

# 1/0 Boolean flag for my optional arguments
#parse options with getopts and proceed with a different method for each
username=""
#parse options with getopts and proceed with a different method for each
while getopts ":u:g:s:h" opt;
do
	
	case $opt in
		u)
			if [[ -z ${OPTARG} ]] ||  [[ -d ~/${OPTARG} ]] ;
			then
				echo "this user is already created or 
				additional argument require see
				-u[username]"
				exit 1
			else
				useradd -d ~/${OPTARG}
				echo " add a password for the user"
				passwd ${OPTARG}
				username=${OPTARG}
			fi
			;;
		g)
			if [[ -z ${OPTARG} ]] || [[ -z ${username} ]];
			then
				echo " additional argument required see
				-g["group"]"
				exit 1
			else
				usermod -aG ${OPTARG} ${username}
			fi
			;;
		s)
			if [[ -z ${OPTARG} ]] || [[ -z ${username} ]];
			then
				echo "additional argument required see
				-s[""]"
			else
				usermod -s /etc/shells/${OPTARG} ${username}
			fi
			;;
		
		h)
			echo "this script requires root or sudo
			privelages.options -u -g -s 
			((username, groups, shell)) require
                        and additional [argument]
                        -h for assistance"
			exit 1
                        ;;

		*)
			echo "useage:
                        sudo mandatory -u[username] 
			-g[grouptoadduserto] -s[usersprefferedshell] -h"
			exit 1
			;;
	esac
done
