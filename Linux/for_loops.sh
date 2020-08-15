#! /bin/bash

# Create Variables

numbers=$(echo {1..9})

states=(
	'Texas'
	'North_Carolina'
	'Hawaii'
	'California'
	'Georgia'
	)

lsout=$(ls)

# Create your For Loops

for number in ${numbers[@]}
do
	if [$numbers = 3] || [$numbers = 7]
