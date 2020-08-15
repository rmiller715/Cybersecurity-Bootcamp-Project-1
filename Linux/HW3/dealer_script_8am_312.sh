#! /bin/bash

#get the information for 8 am 3/12 -- 7
echo 8 am march 12
grep -w "08:00:00 AM" 0312_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}'

