# Полезные команды BASH

## Узнать последнюю строку файла:

 - Использование sed (редактор потока): `sed -n '$p' fileName`
 - Использование хвоста: `tail -n 1 fileName`
 - используя awk: awk `'END { print }' fileName`

## Возвращает полный путь к указанному файлу

 - путь к фалу t.txt в текущей папке `readlink -e t.txt`

## Посик уникальных строк в файале

`uniqNum=$(awk '{print $9}' $dir | uniq -u | wc -l)`
 - `awk '{print $9}'` - выводит 9-е слово каждоой строки

 - `uniq -u` - выбирает только уникальные строки, 
если значене повторяется 2 или больше раз то оно не учитывается

 - `wc -l` - подсчет строк

 - `uniq -d` - выводит строки которые повторяются хотя бы один раз

## Входные параметры скрипта

 - `$0` - имя запущенного файла
 - `$#` - кол-во параметров
 - `$@` - вафля для перебора оператoром `in`. содержит все параметры пословно
 - `$*` - все аргументы переданные скрипту в одной строке
 - `$$` - иденитификотор процесса
 - `$!` - PID последнего запущенного в фоне процесса
 - `[[ -e $1 ]]` - проверяет является ли первый параметр файлом
 - `[[ -n $1 ]]` - проверяет что первый параметр не пустой
 - `[[ -z $2 ]]` - проверяет что первый параметр является пустым

## Зарезервированные переменные
 - `$DIRSTACK` — содержимое вершины стека каталогов
 - `$EDITOR` — текстовый редактор по умолчанию
 - `$EUID` — Эффективный UID. Если вы использовали программу su для выполнения команд от другого пользователя, то эта переменная содержит UID этого пользователя, в то время как.
 - `$UID` — . содержит реальный идентификатор, который устанавливается только при логине.
 - `$FUNCNAME` — имя текущей функции в скрипте.
 - `$GROUPS` — массив групп к которым принадлежит текущий пользователь
 - `$HOME` — домашний каталог пользователя
 - `$HOSTNAME` — ваш hostname
 - `$HOSTTYPE` — архитектура машины.
 - `$LC_CTYPE` — внутренняя переменная, котороя определяет кодировку символов
 - `$OLDPWD` — прежний рабочий каталог
 - `$OSTYPE` — тип ОС
 - `$PATH` — путь поиска программ
 - `$PPID` — идентификатор родительского процесса
 - `$SECONDS` — время работы скрипта(в сек.)

## Команда AWK
### Использование переменных оболочки в программах AWK

Если вы используете команду awk в сценариях оболочки, велика вероятность, что вам потребуется передать переменную оболочки программе awk.
Один из вариантов — заключить программу в двойные вместо одинарных кавычек и подставить переменную в программе.
Однако эта опция сделает вашу awk-программу более сложной, так как вам нужно будет избежать переменных awk.

Рекомендуемый способ использования переменных оболочки в программах awk — присвоить переменную оболочки переменной awk.  Вот пример:

```sh
num=51
awk -v n="$num" 'BEGIN {print n}
```

## Чтение файла

`read` - читает файл построчно в переменную `line`
`IFS` - внутренний разделитьль по умолчанию = пустой строке

```sh
Считывает файл (/ etc / passwd) по строкам и по полям
#!/bin/bash
FILENAME="/etc/passwd"
while IFS=: read -r username password userid groupid comment homedir cmdshell
do
  echo "$username, $userid, $comment $homedir"
done < $FILENAME
В файле unix password информация пользователя хранится по очереди, каждая строка состоит из информации для пользователя, разделенного символом двоеточия (:). В этом примере при чтении файла строки за строкой строка также разделяется на поля с использованием символа двоеточия в качестве разделителя, который обозначается значением, заданным для IFS.

Пример ввода

mysql:x:27:27:MySQL Server:/var/lib/mysql:/bin/bash
pulse:x:497:495:PulseAudio System Daemon:/var/run/pulse:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
tomcat:x:91:91:Apache Tomcat:/usr/share/tomcat6:/sbin/nologin
webalizer:x:67:67:Webalizer:/var/www/usage:/sbin/nologin
Образец вывода

mysql, 27, MySQL Server /var/lib/mysql
pulse, 497, PulseAudio System Daemon /var/run/pulse
sshd, 74, Privilege-separated SSH /var/empty/sshd
tomcat, 91, Apache Tomcat /usr/share/tomcat6
webalizer, 67, Webalizer /var/www/usage
Чтобы читать строки за строкой и иметь всю строку, назначенную переменной, ниже приведена модифицированная версия примера. Обратите внимание, что у нас есть только одна переменная по названию.

#!/bin/bash
FILENAME="/etc/passwd"
while IFS= read -r line
do
  echo "$line"
done < $FILENAME
Пример ввода

mysql:x:27:27:MySQL Server:/var/lib/mysql:/bin/bash
pulse:x:497:495:PulseAudio System Daemon:/var/run/pulse:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
tomcat:x:91:91:Apache Tomcat:/usr/share/tomcat6:/sbin/nologin
webalizer:x:67:67:Webalizer:/var/www/usage:/sbin/nologin
Образец вывода

mysql:x:27:27:MySQL Server:/var/lib/mysql:/bin/bash
pulse:x:497:495:PulseAudio System Daemon:/var/run/pulse:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
tomcat:x:91:91:Apache Tomcat:/usr/share/tomcat6:/sbin/nologin
webalizer:x:67:67:Webalizer:/var/www/usage:/sbin/nologin
Чтение строк файла в массив
readarray -t arr <file
Или с петлей:

arr=()
while IFS= read -r line; do
   arr+=("$line")
done <file
Зацикливание через файл по строкам
while IFS= read -r line; do
   echo "$line"
done <file
Если файл не может содержать новую строку в конце, тогда:

while IFS= read -r line || [ -n "$line" ]; do
   echo "$line"
done <file
Чтение строк строки в массив
var='line 1
line 2
line3'
readarray -t arr <<< "$var"
или с петлей:

arr=()
while IFS= read -r line; do
   arr+=("$line")
done <<< "$var"
Зацикливание строк по строкам
var='line 1
line 2
line3'
while IFS= read -r line; do
   echo "-$line-"
done <<< "$var"
или же

readarray -t arr <<< "$var"
for i in "${arr[@]}";do
    echo "-$i-"
done
Зацикливание через вывод командной строки за строкой
while IFS= read -r line;do
    echo "**$line**"
done < <(ping google.com)
или с трубой:

ping google.com |
while IFS= read -r line;do
    echo "**$line**"
done
Чтение поля файла по полю
Предположим, что разделитель полей : (двоеточие) в файле файла .

while IFS= read -d : -r field || [ -n "$field" ]; do
   echo "$field"
done <file
Для контента:

first : se
con
d:
    Thi rd:
    Fourth
Выход:

**first **
** se
con
d**
**
    Thi rd**
**
    Fourth
**
Чтение поля строки по полю
Предположим, что разделитель полей :

var='line: 1
line: 2
line3'
while IFS= read -d : -r field || [ -n "$field" ]; do
   echo "-$field-"
done <<< "$var"
Выход:

-line-
- 1
line-
- 2
line3
-
Чтение полей файла в массиве
Предположим, что разделитель полей :

arr=()
while IFS= read -d : -r field || [ -n "$field" ]; do
   arr+=("$field")
done <file
Чтение полей строки в массив
Предположим, что разделитель полей :

var='1:2:3:4:
newline'
arr=()
while IFS= read -d : -r field || [ -n "$field" ]; do
   arr+=("$field")
done <<< "$var"
echo "${arr[4]}"
Выход:

newline
Зацикливание через вывод поля команды по полю
Предположим, что разделитель полей :

while IFS= read -d : -r field || [ -n "$field" ];do
    echo "**$field**"
done < <(ping google.com)
Или с трубой:

ping google.com | while IFS= read -d : -r field || [ -n "$field" ];do
    echo "**$field**"
done
```

