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

echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
echo -e "Menu Utama"
echo -e "${blue}――――――――――――――――――――――――――――――――――――――――${noclr}"
echo -e "01)   ${yellow}Create Trial Account${noclr}"
echo -e "02)   ${yellow}Generate Accounts${noclr}"
echo -e "03)   ${yellow}Create Account${noclr}"
echo -e "04)   ${yellow}Lock Account${noclr}"
echo -e "05)   ${yellow}Unlock Account${noclr}"
echo -e "06)   ${yellow}Delete User Account${noclr}"
echo -e "07)   ${yellow}Accounts List${noclr}"
echo -e "08)   ${yellow}Online Accounts List${noclr}"
echo -e "09)   ${yellow}Speedtest [--share]${noclr}"
echo -e "10)   ${yellow}VPS Info${noclr}"
echo -e "${blue}――――――――――――――――――――――――――――――――――――――――${noclr}"
echo -e "Input your choice [01-10]: "
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
