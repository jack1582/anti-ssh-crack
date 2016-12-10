# intro
A set of scripts and docs to anti ssh crack attempts behaviour.

# background
One day, I found that my server logged a lot of ssh connect attempts,of course not by myself.
So, this script borned

# dependence
* ipset, which is a userspace binary to manipulate a hash map in kernel

install: just `yum install -y ipset`

* iptables. almost all linux server have already installed this tool-set

# script notes
* iptables-fw.sh

Assume you will copy it into `/etc/iptables-fw.sh`
It is very easy, notes omitted. ^_^


* anti-ssh-crack.sh

Assume you will copy it into `/etc/ipset/anti-ssh-crack.sh`
The script read `/var/log/secure` log file which is produced by sshd,then:
    - extract recent logs (today for now. u can modify it easily)
    - collect out the remote ip match `Invalid user` line or `Failed password` line
    - count the occurence of each individual ip 
    - set the ip that occured more than 10 times, into ipset named with `anti-ssh-crack`

# start
* run the `/etc/ipset/anti-ssh-crack.sh`.

To work continually , modify crontab, append one line :
`* * * * * /etc/ipset/anti-ssh-crack.sh >/dev/null 2>&1`

* check it! run `ipset list anti-ssh-crack`

** CAUTION: ** be sure your ip is not in the list. run cmd `last` to find your self.

* start iptables: `/etc/iptables-fw.sh` 

** TIPS:** if u ping the ip in the ipset-list, u will find ping says "not permitted", that means it works!. 
you can make it pingable just by delete the OUTPUT rule in iptables-fw.sh.

* enjoy a cup of coffee, than check your exploit! (by `iptables -nvL`)

the `-v` will make the counter displayed for each iptables rule.
