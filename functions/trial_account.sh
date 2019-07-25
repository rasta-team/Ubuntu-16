#!/usr/bin/env bash

clear

# Colors
blue='\e[0;34m'
yellow='\e[0;33m'
noclr='\e[0m'

if [[ "$UID" -ne 0 ]] ; then
    echo "${red}You need to run this as root!${noclr}"
    exit 1
fi

IPADDR=$(wget -qO- ipv4.icanhazip.com);
USERNAME=`</dev/urandom tr -dc A-Z | head -c5`
PASSWORD=`</dev/urandom tr -dc 0-9 | head -c5`
EXPDAY="1"
useradd -e `date -d "$EXPDAY days" +"%Y-%m-%d"` -s /bin/false -M $USERNAME
EXPDATE=$(date -d "$EXPDAY days" +"%Y-%m-%d");
echo -e "$PASSWORD\n$PASSWORD\n"|passwd $USERNAME &> /dev/null

clear

echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
echo -e "Trial Account Details "
echo -e "${blue}――――――――――――――――――――――――――――――――――――――――${noclr}"
echo -e "Ip Address: ${yellow}$IPADDR${noclr}" 
echo -e "OpenSSH Port: ${yellow}2020${noclr}"
echo -e "Dropbear Port: ${yellow}4343${noclr}"
echo -e "Squid Port: ${yellow}3128${noclr}"
echo -e "Username: ${yellow}$USERNAME${noclr}"
echo -e "Password: ${yellow}$PASSWORD${noclr}"
echo -e "Active Until: ${yellow}$EXPDATE${noclr}"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
echo
