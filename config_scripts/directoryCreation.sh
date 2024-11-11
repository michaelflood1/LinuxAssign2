#!/bin/env bash


usrHomeDir=$(getent passwd $SUDO_USER | cut -d: -f6)
cloneLocation=${usrHomeDir}/Clone_repo
mkdir ${cloneLocation}
echo "cloning"

git clone https://gitlab.com/cit2420/2420-as2-starting-files.git ${cloneLocation}/

echo "home dir: $usrHomeDir"

if [[ -f ${usrHomeDir}/creationAllowed ]]; then
	cp -rs ${cloneLocation}/* ${usrHomeDir}/
	ln -sfn ${usrHomeDir}/bash.rc ${cloneLocation}/bashrc
fi


