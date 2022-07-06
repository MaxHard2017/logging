#! /bin/bash
if [ $# -eq 0 ]; then
	echo "No arguments supplied"
	exit 1
fi

dir=$1
lineNum=$(wc -l $dir | cut -d' ' -f1)
echo Total records: $lineNum
uniqNum=$(awk '{print $9}' $dir| uniq -u | wc -l)
echo Unicue SHA: $uniqNum
duplNum=$(awk '{print $9}' $dir| uniq -d | wc -l)
echo Duplicate SHA :$duplNum
