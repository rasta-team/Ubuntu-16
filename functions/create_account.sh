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

IPADDR=$(wget -qO- ipv4.icanhazip.com);

echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
echo "Create: Account"
echo -e "${blue}――――――――――――――――――――――――――――――――――――――――${noclr}"

read -p "Username: " USERNAME
egrep "^$USERNAME" /etc/passwd > /dev/null
if [ $? -eq 0 ]; then
    echo "Username already exists in your server"
    exit 0
else
    read -p "Password: " PASSWORD
    read -p "Expired [Day]: " EXPDAY
    EXPDATE=$(date -d "$EXPDAY days" +"%Y-%m-%d");
    useradd -e "$EXPDATE" -s /bin/false -M "$USERNAME"

    clear

    echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
    echo "Account Details"
    echo -e "${blue}――――――――――――――――――――――――――――――――――――――――${noclr}"

    echo -e "Ip Address: ${yellow}$IPADDR${noclr}"
    echo -e "Dropbear Port: ${yellow}4343${noclr}"
    echo -e "OpenSSH Port: ${yellow}2020${noclr}"
    echo -e "Squid Port: ${yellow}3128${noclr}"
    echo -e "Username: ${yellow}$USERNAME${noclr}"
    echo -e "Password: ${yellow}$PASSWORD${noclr}"
    echo -e "Active Until: ${yellow}$EXPDATE${noclr}"
    echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
fi
