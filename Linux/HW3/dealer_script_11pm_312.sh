#! /bin/bash



#get the information for 11 pm 3/12 -- 10
echo 11 pm  march 12
grep -w "11:00:00 PM" 0312_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}'

