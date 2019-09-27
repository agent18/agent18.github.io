#!/bin/bash 

# https://unix.stackexchange.com/questions/31414/how-can-i-pass-a-command-line-argument-into-a-shell-script

# https://askubuntu.com/a/972347/443958

# echo "file name: $1"

# echo "save name: $2"

#grep -A1 '^**Check' 2019-08-03-identifying-patterns-subject-predicate.markdown > new_file.csv

# grep -A3 '^**Check' $1 > $2 # Select lines with **Check and Next line

# grep -v '^--' $2 > new_file2.csv # remove lines with --
# grep -v '^>' $2 > new_file2.csv # remove lines with >
# grep -v '^#' $2 > new_file2.csv # remove lines with #
# grep -v '^<!' $2 > new_file2.csv # remove lines with <!

#sed 'N;s/\n/ /' new_file2.csv > new_file3.csv # make one line

# https://unix.stackexchange.com/a/507531/267853
## Get lines marked by checklist and empty line
sed -ne '/Checklist/{x;P;x};/Checklist/,/^$/p' $1 > new_file.csv 

## Make everything one line
# https://stackoverflow.com/a/55449534/5986651
awk 'BEGIN { RS=""; ORS="\n\n"}{$1=$1}1' new_file.csv > new_file2.csv

## Count and store in file

exmade=$(grep -E "\*example-matching-definition\*.{0,10}(unsure|almost|time|failed)" new_file2.csv)

noex=$(grep -E "\*no-example\*.{0,10}(unsure|almost|time|failed)" new_file2.csv)

ens=$(grep -E "ensures.{0,10}(unsure|almost|time|failed)" new_file2.csv)

deun=$(grep -E "\*definition-unclear\*.{0,10}(unsure|almost|time|failed)" new_file2.csv)

mico=$(grep -E "\*missed-comparison\*.{0,10}(unsure|almost|time|failed)" new_file2.csv)

suprsp=$(grep -E "\*subject-predicate-split\*.{0,10}(unsure|almost|time|failed)" new_file2.csv)

exmasu=$(grep -E "\*example-matching-subject\*.{0,10}(unsure|almost|time|failed)" new_file2.csv)

cuz=$(grep -E "\*because-should-due-to\*.{0,5}(unsure|almost|time|failed)" new_file2.csv)

fai=$(grep -E "\*\*Check.*(unsure|almost|time|failed)" new_file2.csv)

tot=$(grep -E "^\*\*Check" new_file2.csv)

echo "$exmade" > new_file_failures.csv
echo exmade > new_file_count.csv
echo "$exmade" | wc -l >> new_file_count.csv

echo "" >> new_file_failures.csv
echo "$noex" >> new_file_failures.csv
echo "" >> new_file_count.csv
echo noex >> new_file_count.csv
echo "$noex" | wc -l >> new_file_count.csv

echo "" >> new_file_failures.csv
echo "$ens" >> new_file_failures.csv
echo "" >> new_file_count.csv
echo ens >> new_file_count.csv
echo "$ens" | wc -l >> new_file_count.csv

echo "" >> new_file_failures.csv
echo "$deun" >> new_file_failures.csv
echo "" >> new_file_count.csv
echo  deun >> new_file_count.csv
echo "$deun" | wc -l >> new_file_count.csv

echo "" >> new_file_failures.csv
echo "$mico" >> new_file_failures.csv
echo "" >> new_file_count.csv
echo mico >> new_file_count.csv
echo "$mico" | wc -l >> new_file_count.csv

echo "" >> new_file_failures.csv
echo "$suprsp" >> new_file_failures.csv
echo "" >> new_file_count.csv
echo suprsp >> new_file_count.csv
echo "$suprsp" | wc -l >> new_file_count.csv

echo "" >> new_file_failures.csv
echo "$exmasu" >> new_file_failures.csv
echo "" >> new_file_count.csv
echo  exmasu >> new_file_count.csv
echo "$exmasu" | wc -l >> new_file_count.csv

echo "" >> new_file_failures.csv
echo "$cuz" >> new_file_failures.csv
echo "" >> new_file_count.csv
echo  cuz >> new_file_count.csv
echo "$cuz" | wc -l >> new_file_count.csv

echo "" >> new_file_count.csv
echo  fai >> new_file_count.csv
echo "$fai" | wc -l >> new_file_count.csv

echo "" >> new_file_count.csv
echo  tot >> new_file_count.csv
echo "$tot" | wc -l >> new_file_count.csv

#echo "$" > new_file_failures.csv 

## Usage
#./checklist-dp.sh 2019-08-18-superintelligence.markdown


