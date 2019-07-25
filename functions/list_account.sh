#!/usr/bin/env bash

clear

if [[ "$UID" -ne 0 ]] ; then
    echo "${red}You need to run this as root!${noclr}"
    exit 1
fi

# Colors
red='\e[0;31m'
blue='\e[0;34m'
noclr='\e[0m'

echo "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
echo "PID    Username    Expired    "
echo "${blue}――――――――――――――――――――――――――――――――――――――――${noclr}"
while read EXPUSER ; do
	USERACC="$(echo $EXPUSER | cut -d: -f1)"
	USERID="$(echo $EXPUSER | grep -v nobody | cut -d: -f3)"
	EXPDATE="$(chage -l $USERACC | grep "Account expires" | awk -F": " '{print $2}')"
	if [[ $USERID -ge 1000 ]]; then
		printf "%-17s %2s\n" "$USERACC" "$EXPDATE"
	fi
done < /etc/passwd

TOTALACC="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo "${blue}――――――――――――――――――――――――――――――――――――――――${noclr}"
echo "Total Account: $TOTALACC user"
echo "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${noclr}"
echo
