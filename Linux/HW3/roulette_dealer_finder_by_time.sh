#! /bin/bash

#input the date($1 - 4 digits) and time (#2) and output the time and dealer
grep -w "$2 $3"  $1_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}' 
