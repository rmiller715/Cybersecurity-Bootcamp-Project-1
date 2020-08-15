#! /bin/bash

#get the information for 2 pm 3/15 -- 13
echo 2 pm march 15
grep -w "02:00:00 PM" 0315_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}'

