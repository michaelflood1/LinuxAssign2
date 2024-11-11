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


#parse options with getopts and proceed with a different method for each
username="" #used to store -u arg soon
#parse options with getopts and proceed with a different method for each
while getopts ":u:g:s:h" opt; # allows us to make a case statement and use the input args from user
do
	
	case $opt in
		u)
			if [[ -z ${OPTARG} ]] ||  [[ -d ~/${OPTARG} ]] ; # if home dir exists the user is already create, if the optarg doesnt exist we cannot follow the script
			then
				echo "this user is already created or 
				additional argument require see
				-u[username]"
				exit 1
			else
				useradd -d ~/${OPTARG} "${OPTARG}  #adds user then calls to create a password
				echo " add a password for the user"
				passwd ${OPTARG}
				username=${OPTARG} # stores username for later
			fi
			;;
		g)
			if [[ -z ${OPTARG} ]] || [[ -z ${username} ]]; # standard error check to stop typos
			then
				echo " additional argument required see
				-g["group"]"
				exit 1
			else
				usermod -aG ${OPTARG} ${username} #adds group to specified user
			fi
			;;
		s)
			if [[ -z ${OPTARG} ]] || [[ -z ${username} ]];
			then
				echo "additional argument required see
				-s[""]"
			else
				usermod -s /etc/shells/${OPTARG} ${username} # adds a shell/enviorenment variable to the user
			fi
			;;
		
		h) # provides detailed info to the user
			echo "this script requires root or sudo
			privelages.options -u -g -s 
			((username, groups, shell)) require
                        and additional [argument]
                        -h for assistance"
			exit 1
                        ;;

		*) # submits correct syntax for the user that sent a wrong input
			echo "useage:
                        sudo mandatory -u[username] 
			-g[grouptoadduserto] -s[usersprefferedshell] -h"
			exit 1
			;;
	esac
done
