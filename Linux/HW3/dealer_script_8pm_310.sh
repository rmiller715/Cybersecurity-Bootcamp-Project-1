#! /bin/bash


#get the information for 8 pm 3/10 -- 4
echo 8 pm march 10
grep -w "08:00:00 PM" 0310_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}'

