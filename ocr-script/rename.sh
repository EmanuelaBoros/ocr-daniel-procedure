#!/bin/bash

find $1 -name "*.txt" -type f | while read file; do
	echo $file
	#echo ${file//$2/}
	mv "$file" "${file//$2/}"
done
