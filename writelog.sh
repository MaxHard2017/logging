#!/bin/bash

if [[ $# -eq 0 ]] ;then 
	echo "No arguments supplied"
	exit 1
fi

silence="false"		# определяет будут ли выводится сообщения
while [ -n "$1" ]
do
    case "$1" in
	     -s)
		silence="true"	#при вызове с параметром -s 
		# сообщения не выводятся 
		shift ;;
    --help | -h)
		echo HELP: writelog.sh - for logging changes of edited file
		echo 
		echo Usage: ./writelog.sh [file name] [optional: log dir]
		echo
		echo - [file name] - full path and name of the file which changes should be logged.
		echo - [log dir]   - full path to prefered directory for log file
		echo [log gir] by default = directory of the logged file [file name]
		echo
		echo Log file structure is determined by the [logpettern] text file.
		echo Fields delimeted by \":\" could be ommited or subsequesce couid be changed.
		echo The default fields are: [filepath:size:date:summ:algorithm:]
		echo If file [logpattern] is found in loged file directory  it will be used.
		echo If no, then it is searched in writelog.sh directory.
		echo If no, then it would be created with default fields in the directory of the logged [file name] file.
		exit 0;;

         *) break ;;
    esac
done

if [[ "$silence" == "false" ]]; then echo Silence = $silence; fi


if !( [[ -e $1 ]] ) 
    then
        echo "Can not finde file $1 which should be logged"
	exit 1
    else
	    loggedFile=$(readlink -f $1) # Путь к файлу который хотим логировать	   
fi

logdir=$(dirname $(readlink -f $loggedFile))
				# по умолчанию прописываем путь к файлу лога в
				# ту же директорию где лежит и логируемый файл 

if ( [[ -d $2 ]] ) ;then 	# если задан второй параметр как альтернативная 
	logdir=$( readlink -f $2 )
elif ( [[ -n $2 ]] ) ;then
	echo "Wrong path for a log file: '$2'"
	exit 1
fi

if  [[ -e $logdir"/logpattern" ]] ;then 
# если паттерн нашелся в дирректории файла логирования 
# тогда берем его за образец
	logptt=$logdir"/logpattern"

elif [[ -e "./logpattern" ]] ;then # если не нашелся ищем локально
	logptt="./logpattern"
else
# если паттерна нет то создаем паттерн по умолчанию в дирректории логирования
	logptt=$logdir"/logpattern"
	if  [[ "$silence" == "false" ]] # надо ли выводить собщения
		then
			echo No log pattern found
			echo Creating default pattern in: $logptt
	fi

	echo filepath:size:date:summ:algorithm: >> $logptt
fi


logdir+=/file.log		# доплняем имя файл в в кторый будем писать лог

while IFS= read -d : -r field || [ -n "$field" ]; do
   arr+=("$field")
done < $logptt # '<' в цикл передаем путь к файлу паттерна в 'read'


out=""
for i in "${arr[@]}";do	# собираем запись в лог по паттерну
    case "$i" in
            date) 
		  out+=$(ls -l $loggedFile | cut -d' ' -f6-8)
		  out+=" - ";;
	    size)
		  out+=$(ls -l $loggedFile | cut -d' ' -f5)
		  out+="byte - " ;;
		
            summ) 
		  out+=$(openssl sha256 $loggedFile | cut -d' ' -f2)
		  out+=" - " ;;
	filepath)
		  out+=$(readlink -e $loggedFile)
		  out+=" - " ;;
	algorithm)
		  out+=$(openssl sha256 $loggedFile | cut -d'(' -f1)
		  out+=" - " ;;
    esac
done

if !( [[ -e $logdir ]] );then touch $logdir; fi

if  [[ "$silence" == "false" ]]		# надо ли выводить сообщения
	then
		echo Log pattern used: $logptt
		echo Changes in: $loggedFile 
		echo will be logged to: $logdir
fi
echo "$out" >> $logdir
