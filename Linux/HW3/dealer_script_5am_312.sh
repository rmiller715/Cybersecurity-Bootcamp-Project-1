#! /bin/bash


#get the information for 5 am 3/12 -- 6
echo 5 am march 12
grep -w "05:00:00 AM" 0312_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}'

