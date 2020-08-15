#! /bin/bash


#get the information for 11 pm 3/10 -- 5
echo 11 pm march 10
grep -w "11:00:00 PM" 0310_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}'

