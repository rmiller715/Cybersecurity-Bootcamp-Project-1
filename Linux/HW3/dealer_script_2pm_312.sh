#! /bin/bash

#get the information for 2 pm 3/12 -- 8
echo 2 pm  march 12
grep -w "02:00:00 PM" 0312_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}'

