#! /bin/bash


#get the information for 2 pm 3/10 -- 3
echo 2 pm march 10
grep -w "02:00:00 PM" 0310_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}'

