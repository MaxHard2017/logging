#!/bin/bash

if [[ $# -eq 0 ]] ;then 
	echo "No arguments supplied"
	exit 1
fi

if !( [[ -e $1 ]] ) ;
    then
        echo "Can not finde file $1 for logging"
	exit 1
    else
	loggedFile=$1		# Путь к файлу который хотим логировать	   
fi

logdir=$(dirname $(readlink -e $loggedFile))
				# по умолчанию прописываем путь к файлу лога в
				# ту же директорию где лежит и логируемый файл 

if ( [[ -d $2 ]] ) ;then 	# если задан второй параметр как альтернативная 
				# директория лога, проверяем ее на существование
	logdir=$(readlink -e $2)
    else
	echo "Wrong path for a log file:  '$2'"
fi

if  [[ -e $logdir"/logpattern" ]] ;then 
# если паттерн нашелся в дирректории файла логирования 
# тогда берем его за образец
	logptt=$logdir"/logpattern"
	echo Log pattern used: $logptt
elif [[ -e "./logpattern" ]] ;then # если не нашелся ищем локально
	logptt="./logpattern"
	echo Log pattern used: $logptt
else
# если паттерна нет то создаем паттерн по умолчанию в дирректории логирования
	logptt=$logdir"/logpattern"
	echo No log pattern found
	echo creating default pattern in: $logptt
	echo filepath:size:date:summ:algorithm: >> $logptt
	echo $logptt
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
		  out+="byte - ";;
		
            summ) 
		  out+=$(openssl sha256 $loggedFile | cut -d' ' -f2)
		  out+=" - ";;
	filepath)
		  out+=$(readlink -e $loggedFile)
		  out+=" - ";;
	algorithm)
		  out+=$(openssl sha256 $loggedFile | cut -d'(' -f1)
		  ;;
    esac
done

echo Changes in: $loggedFile 
echo Will be logged to: $logdir
if !( [[ -e $logdir ]] );then touch $logdir; fi
echo "$out" >> $logdir
