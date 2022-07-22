#! /bin/bash
if [ $# -eq 0 ]; then
	echo "No arguments supplied"
	exit 1
fi
i
while [ -n "$1" ]
do
    case "$1" in
	-a) echo "Found the -a option";; # TBD -a option without parameter

	-b) param="$2"                   # TBD -b option with parametr
	    echo "Found the -b option, with parameter value $param"
	    shift ;;			# сдвиг 

	--) shift
 	    break ;;

 --help | -h) 
	    echo HELP: log_anal.sh - for analyzing chages of selected file [file name]
	    echo by parsing apropriated log file

	    echo 
	    echo Usage: ./log_anal.sh [log file] [file name]
	    echo - [log  file] - full path and name of the parsed log file
	    echo - [file name] - full path and name of the file which changes are logged 
	    echo and wanted to be analyzed 
	    exit 0;;

         *) break ;;
    esac
    shift
done

count=1
for param in "$@" 		# цикл вывода входных параметров - для дебага
do
#    echo "Parameter #$count: $param"
    count=$(( $count + 1 ))
done

if !( [[ -e $1 ]] ) 		# проверка нализия файла логов
then
    echo Can not find file $1
    exit 1
fi    

if !( [[ -e $2 ]] ) 		# проверка наличия анализируемого файла
then
    echo Can no find file $2
    exit 1
fi

dir=$1
changedFile=$2
lineNum=$(wc -l $dir | cut -d' ' -f1)
echo Parsing change log: $dir ...
echo analyzing changes in: $changedFile
echo Total file changes: $lineNum
#awk -v cf="$changedFile" '$1 == cf { print $1 }' $dir

uniqNum=$( awk -v cf="$changedFile" '$1 == cf { print $9 }' $dir | uniq -u | wc -l )
echo Unique - $uniqNum
duplNum=$( awk -v cf="$changedFile" '$1 == cf { print $9 }' $dir | uniq -d | wc -l )
echo Duplicate - $duplNum
echo "Content changes (sha256 was changed): " $[ $uniqNum + $duplNum]
echo Last change:
echo ------------
awk '{print $0}' $dir | tail -n 1
