#! /bin/bash

mkdir ~/research 2>/dev/null

# Define Variables

sysfile= '/home/sysadmin/research/sys_info.txt'
variable=$(ip addr | grep inet | tail -2 | head -1)

touch >> $sysfile

echo "A Quick System Audit Script" >> $sysfile

date >> $sysfile

echo "" >> $sysfile

echo "Machine Type Info" >> $sysfile
echo $MACHTYPE >> $sysfile

echo -e "Uname Info: $(usame -a) \n" >> $sysfile

echo -e "IP INFO: $variable \n" >> $sysfile

echo -e "Hostname: $(hostname -s) \n" >> $sysfile

echo "DNS Servers: " >> $sysfile
cat /etc/resolv.conf >> $sysfile

echo -e "\nMemory Info:" >> $sysfile
free >> $sysfile

echo -e "\nDisk Usage:" >> $sysfile
df -H | head -2  >> $sysfile

echo -e "\nWho ia logged in: \n $(who -a) \n" >> $sysfile

echo -e "\nSUID Files:" >> $sysfile
sudo find / -type f -perm /4000 >> $sysfile

echo -e "\nTop 10 processes" >> $sysfile
ps aux --sort -%mem | awk {'print $1, $2,$3,$4, $11'} | head  >> $sysfile

 
