#!/bin/bash 

# https://unix.stackexchange.com/questions/31414/how-can-i-pass-a-command-line-argument-into-a-shell-script

# https://askubuntu.com/a/972347/443958

echo "file name: $1"

echo "save name: $2"

#grep -A1 '^**Check' 2019-08-03-identifying-patterns-subject-predicate.markdown > new_file.csv

grep -A1 '^**Check' $1 > $2 # Select lines with **Check and Next line

grep -v '^--' $2 > new_file2.csv # remove lines with --

sed 'N;s/\n/ /' new_file2.csv > new_file3.csv 


