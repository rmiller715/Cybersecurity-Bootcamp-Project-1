#! /bin/bash

#Free Memory 
free -h >> ./Projects/backups/freemem/free_mem.txt

#Free Disk Usage
df -h >> ./Projects/backups/freedisk/free_disk.txt

#Open Files 
lsof >> ./Projects/backups/openlist/open_list.txt

#Disk Usage
du -h >> ./Projects/backups/diskuse/disk_usage.txt


