#! /bin/bash

dir="$1"
searchVal="$2"
newVal="$3"
dateTime=$(ls -l $dir | cut -d' ' -f6-9)
size=$(ls -l $dir | cut -d' ' -f5)
hash=$(openssl sha256 $dir | cut -d' ' -f2)
algorithm=$(openssl sha256 $dir | cut -d'(' -f1)

echo 'In file:' $dir 
echo 'Value <'$searchVal'> will be changed to  Value <'$newVal'>'
sed -i 's/'$searchVal'/'$newVal'/' $dir
echo logging changes to ./file.log:


echo $dir' - '$size'byte - '$dateTime' - '$hash' - '$algorithm >> ./file.log