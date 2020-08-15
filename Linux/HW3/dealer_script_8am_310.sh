#! /bin/bash

#get the information for 8 am 3/10 -- 2
echo 8 am march 10
grep -w "08:00:00 AM" 0310_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}'

