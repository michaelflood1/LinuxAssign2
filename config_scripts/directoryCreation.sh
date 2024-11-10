#!/bin/env bash

git clone https://gitlab.com/cit2420/2420-as2-starting-files.git
workDir=$(dirname $("realpath "$0")")

if [[ ! -d ~/bin ]]; 
	then
	mkdir ~/bin
	ln -s "${workDir}/bin" ~/bin
fi

if [[ ! -d ~/config ]];
	then
	mkdir ~/config
	ln -s "${workDir}/config" ~/bin
fi

if [[ ! -d ~home]];
	then mkdir ~/home
	touch ~/home/bashrc
	ln -s "${workDir}/home" ~/home/.bashrc
fi


