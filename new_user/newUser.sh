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

# 1/0 Boolean flag for my optional arguments
uFlag=""
gFlag=""
cFlag=""
#parse options with getopts and proceed with a different method for each
while getopts ":u:g:s:h" opt;
do
	case $opt in
		u) 
			uFlag="U" #shows username has been input
			;;
		g)
			gFlag="G" #shows group has been input
			;;

		s)
			sFlag="S" # shows shell has been input
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


case "${uFlag} ${gFlag} ${sFlag}" in

	U)
		if [[ -d /home/"${u}" ]];
		then
			echo "username must not be taken"
			exit 1
		else
			useradd -d /home/"${u}" "${u}"

			passwd "${u}"

			cp -r /etc/skel/. home/"${u}" 	

		fi
		;;

	U G)
		if [[ ! grep -q "^${g}:" /etc/group ]] || [[ -d /home/"${u}" ]]; then
			echo "group must exist"
			exit 1
		else
			useradd -aG "${g}" -d /home/"${u}" "${u}"
                	passwd "${u}"
			cp -r /etc/skel. /home/"${u}"
		fi
			
			;;

	U S)
		if [[ ! /etc/shells/"${s}" ]] ||  [[ -d /home/"${u}" ]]; then
			echo "arch does not support this shell type or you have an existing user with this name"
			exit 1
		else
			useradd -s /etc/shells/"${s}" -d /home/"${u}" "${u}"
			
			passwd "${u}"
			cp -r /etc/skel/. home/"${u}"
		fi
		;;

	U G S)
		if [[ -d /home/"${u}" ]] || [[ ! grep -q "^${g}:" /etc/group ]] || [[ ! /etc/shells/"${s}" ]]; then
			echo " the username may be in use, the group may not exist, or we do not support your shell type"
		else
			useradd -aG "${g}" -s $"{s} -d /home/"${u} "${u}"
                        passwd "${u}"
                        cp -r /etc/skel/. ~/"${u}"
		fi
		;;
	 *)
		echo "useage:
                        sudo mandatory -u["username"] -g["grouptoadduserto"] -s["usersprefferedshell"] -h"
		;;

ecas
	
