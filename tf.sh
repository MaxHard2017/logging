#!/bin/bash

FILENAME="./pattern"
arr=()
while IFS= read -d : -r field || [ -n "$field" ]; do # читаем из файла (см. 'done' в поле field по разделителю :
# без опции '-d :' будет читать по строчно	
   arr+=("$field")
done < $FILENAME # '<' в цикл передаем путь к файлу в 'read'


out=""
for i in "${arr[@]}";do
    echo "<$i>"
    case "$i" in
	    a) out+="aaaaaa";;
	    b) out+="bbbbb";;
	    c) out+="cccc";;
    esac
done

echo $out
