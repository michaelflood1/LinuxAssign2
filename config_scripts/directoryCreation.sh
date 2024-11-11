#!/bin/env bash

#the goal of this file is to as a root user clone a set git repository into the sudo users home directory.

usrHomeDir=$(getent passwd $SUDO_USER | cut -d: -f6) #the person who called the script
cloneLocation=${usrHomeDir}/Clone_repo # new directory in sudo_users home
mkdir ${cloneLocation} # create the new dir


git clone https://gitlab.com/cit2420/2420-as2-starting-files.git ${cloneLocation}/ #the gitlab repo we are cloning as well as where i want to place it

# if the file is real "made in main.sh" we are allowed to run the file
if [[ -f ${usrHomeDir}/creationAllowed ]]; then
	cp -rs ${cloneLocation}/* ${usrHomeDir}/ #copys recursivly and turns everything it copies into a symlink, placing it at second arg
	ln -sfn ${usrHomeDir}/bash.rc ${cloneLocation}/bashrc # Forcefully creates a new symlink from bashrc to bash.rc
fi


