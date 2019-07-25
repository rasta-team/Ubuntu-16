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

data=(`ps aux | grep -i dropbear | awk '{print $2}'`);
echo -e "${yellow}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
echo "DropBear"
echo -e "${yellow}――――――――――――――――――――――――――――――――――――――――${noclr}"
for PID in "${data[@]}" ; do
	AUTHUSER=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
	USERNAME=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $10}'`;
	IPADDR=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
	if [ $AUTHUSER -eq 1 ]; then
		echo "$PID - $USERNAME - $IPADDR";
	fi
done

data=(`ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);
echo -e "${yellow}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
echo "SecureShell"
echo -e "${yellow}――――――――――――――――――――――――――――――――――――――――${noclr}"
for PID in "${data[@]}" ; do
	AUTHUSER=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
	USERNAME=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
	IPADDR=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}'`;
	if [ $AUTHUSER -eq 1 ]; then
		echo "$PID - $USERNAME - $IPADDR";
	fi
done
echo -e "${yellow}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
