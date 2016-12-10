#!/bin/sh
/sbin/iptables -F INPUT
/sbin/iptables -A INPUT -i lo -j ACCEPT
/sbin/iptables -A INPUT -i eth+ -p tcp --dport 6060:6070 -j REJECT

ipset create -! anti-ssh-crack hash:ip
#/sbin/iptables -A INPUT -m set --match-set anti-ssh-crack src -p tcp --destination-port 22 -j DROP
# more strict
/sbin/iptables -A INPUT -m set --match-set anti-ssh-crack src -j DROP

# test for ipset
/sbin/iptables -F OUTPUT
/sbin/iptables -A OUTPUT -m set --match-set anti-ssh-crack dst -p icmp -j DROP

