#! /bin/bash

#get the information for 5 am 3/10 --1
echo 5 am march 10
grep -w "05:00:00 AM" 0310_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}'


