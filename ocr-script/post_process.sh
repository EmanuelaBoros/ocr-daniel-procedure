#!/bin/bash

find $1 -type f | while read file; do 
	echo $file
	sed -i "" 's///g' $file
	sed -i "" 's/ *$//g' $file
	sed -i "" '/^$/d' $file
done
