#!/usr/bin/env bash

clear

if [[ "$UID" -ne 0 ]] ; then
    echo "${red}You need to run this as root!${noclr}"
    exit 1
fi

# Colors
blue='\e[0;34m'
yellow='\e[0;33m'
noclr='\e[0m'

read -p "Username: " USERNAME
egrep "^$USERNAME" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
    read -p "[+] Expired Day: " ACTIVETIME
    NOWDATE=`date +%s`
    ACTIVETIMESEC=$(($ACTIVETIME * 86400))
    EXPIREDTIME=$(($NOWDATE + $ACTIVETIMESEC))
    EXPIREDATE=$(date -u --date="1970-01-01 $EXPIREDTIME sec GMT" +%Y/%m/%d)
    EXPIREDATEDISP=$(date -u --date="1970-01-01 $EXPIREDTIME sec GMT" '+%d %B %Y')
    clear
    passwd -u $USERNAME
    usermod -e  $EXPIREDATE $USERNAME
    egrep "^$USERNAME" /etc/passwd >/dev/null
    echo -e "$password\n$password" | passwd $USERNAME
    clear
    echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
    echo "User details [Active days]"
    echo -e "${blue}――――――――――――――――――――――――――――――――――――――――${noclr}"
    echo -e "Username: ${yellow}$USERNAME${noclr}"
    echo -e "Expired [Day]: ${yellow}$ACTIVETIME day${noclr}"
    echo -e "Expired Date: ${yellow}$EXPIREDATEDISP${noclr}"
    echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
else
    echo "Username not found!"
    exit 0
fi
