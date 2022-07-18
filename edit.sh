#! /bin/bash
if [ $# -eq 0 ]; then
 echo "No arguments supplied"
 exit 1
fi

dir=$(readlink -e $1)
searchVal="$2"
newVal="$3"

echo 'In file:' $dir 
echo 'Value <'$searchVal'> will be changed to  Value <'$newVal'>'

sed -i s/"$searchVal"/"$newVal"/ $dir

date=$(ls -l $dir | cut -d' ' -f6-8)
size=$(ls -l $dir | cut -d' ' -f5)
sha=$(openssl sha256 $dir | cut -d' ' -f2)
algorithm=$(openssl sha256 $dir | cut -d'(' -f1)

echo $dir - $size"byte - "$date - $sha - $algorithm >> ./file.log
