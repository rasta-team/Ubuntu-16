#!/usr/bin/env bash

clear

if [[ "$UID" -ne 0 ]] ; then
    echo "${red}You need to run this as root!${noclr}"
    exit 1
fi

# Colors
red='\e[0;31m'
green='\e[0;32m'
blue='\e[0;34m'
noclr='\e[0m'

read -p "Username: " USERNAME
egrep "^$USERNAME" /etc/passwd > /dev/null
read -p "Are You Sure? [y/n]: " DELACC
if [[ "$DELACC" = 'y' || "$DELACC" = 'Y' ]]; then
	passwd -l "$USERNAME"
	userdel "$USERNAME"
	echo -e "${green}Success Delete Account${noclr}"
else
	echo -e "${red}Fail Delete Account${noclr}"
fi
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
