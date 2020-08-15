#! /bin/bash



#get the information for 8 am 3/15 -- 12
echo 8 am march 15
grep -w "08:00:00 AM" 0315_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}'

