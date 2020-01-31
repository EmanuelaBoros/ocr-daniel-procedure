#!/bin/bash

find $1 -name "*.png" -type f | while read file; do
	echo $file
	dir=$(dirname "${file}")
	tesseract $file $file -l $2
done

