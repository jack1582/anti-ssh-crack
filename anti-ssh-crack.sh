#!/bin/sh
(
echo create -! anti-ssh-crack hash:ip family inet hashsize 1024 maxelem 65536
echo flush anti-ssh-crack
#echo add anti-ssh-crack 182.254.232.222

tail -n 1000 /var/log/secure|\
awk 'BEGIN {today=strftime("%-d",systime())}
today==$2 && /Invalid user/ {print $NF}
today==$2 && /Failed password/ {print $(NF-3)}' |\
sort |uniq -c |awk '$1>=10 {print "add -! anti-ssh-crack",$2}'
) | /usr/sbin/ipset restore
