#! /bin/bash

#get the informatoin for 5 am 3/15 -- 11
echo 5 am march 15
grep -w "05:00:00 AM" 0315_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}'

