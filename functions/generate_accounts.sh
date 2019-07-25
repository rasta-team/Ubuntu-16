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

read -p "Total Account: " USERS
read -p "Expired [Day]: " EXPDAY
EXPDATE=$(date -d "$EXPDAY days" +"%Y-%m-%d");

echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
echo "Account Details"
echo -e "${blue}――――――――――――――――――――――――――――――――――――――――${noclr}"

echo -e "Ip Address: ${yellow}$IPADDR${noclr}"
echo -e "OpenSSH Port: ${yellow}2020${noclr}"
echo -e "Dropbear Port: ${yellow}4343${noclr}"
echo -e "Squid Port: ${yellow}3128${noclr}"
echo -e "Active Until: ${yellow}$EXPDATE${noclr}"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"

for (( i=1; i <= $USERS; i++ ))
do
    USER=`cat /dev/urandom | tr -dc 'A-Z' | fold -w 5 | head -n 1`
    useradd -M -N -s /bin/false -e $EXPDATE $USER
    PASS=`cat /dev/urandom | tr -dc '0-9' | fold -w 5 | head -n 1`
    echo $USER:$PASS | chpasswd
    echo -e "$i. Username | Password: ${yellow}$USER${noclr} | ${yellow}$PASS${noclr}"
done
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
