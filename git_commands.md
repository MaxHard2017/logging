# Полезные команды GIT

## Начальная начтройка GIT
Настрйоки GIT находятся в файлах `.gitconfig` или `gitconfig` в разных расположениях **(origin)** и имеют разный приоритет для гибкого конфигурирования.

## Приоритеты настроек - 3 Origins

### --system
`[path]/etc/gitconfig` file: Contains values applied to **every user on the system** and all their repositories. If you pass the option **`--system`** to git config, it reads and writes from this file specifically. Because this is a system configuration file, you would need administrative or superuser privilege to make changes to it.

> Папка конфигов в UNIX или папка приложения и его конфигураций в Windows:
> **For Windows:**  It looks for `[path]/etc/gitconfig`, although it’s relative to the MSys root, which is wherever you decide to install Git on your Windows system when you run the installer or directory you choose for portable installation.

### --global
`~/.gitconfig` or `~/.config/git/config` file: Values specific personally to **you, the user**. You can make Git read and write to this file specifically by passing the **--global** option, and this affects all of the repositories you work with on your system.

> Папка конфигов пользователя, обычно его "хоум" папка:
> **For Windows:** Git looks for the `.gitconfig` file in the $HOME directory `C:\Users\$USER` for most people.

### --local
config file in the Git directory (that is, .git/config) of whatever repository you’re currently using: Specific to that single repository. You can force Git to read from and write to this file with the **--local** option, but that is in fact the default. Unsurprisingly, you need to be located somewhere in a Git repository for this option to work properly.

> Папка конфигов выбранного репозитория. Обычно папка `.git` в папке проекта.
> В `--local` origin можно сдлеать настройки GIT специфичные для выбранного проекта.

## Управление конфигом

`git config --list` - вывод всех действующих ключей настроек GIT. Настройки выбираются из всех расположений одинаковые настройки перекрываются в соответствнии с приоритетом **local <- global <- system** и показываются только активные действующие.

`git config --list --show-origin` - вывод всех возможных настроек и их расположение. В каком гитконфиге и месте (origin) расположены.

`git config <origin> <key> <value>` - прописывание ключей настройки по выбранному расположению <origin>.

`git config <key>:` - вывод значения ключа. Если таикх ключей несколько, то выведется приоритетное действующее значение.

Для вывода расположения выбранного действующего ключа:

```sh
$ git config --show-origin rerere.autoUpdate
```

### Must configure

Необходимо прописать identity, так как GIT использует эту инфромацию для каждого коммита.

```sh
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```

### Hacks

Можно прописать системный редактор по умолчанию, который будет вызывасться при коммитах для оформления комментария:

```sh
$ git config --global core.editor emacs
```

## GIT start

### HELP:)

```sh
$ git help <verb>
$ git <verb> --help
$ man git-<verb>
```
[Libera Chat IRC server](https://libera.chat/). In-person help in #git, #github, or #gitlab channels.

### Начало работы
`git init`
`git clone <path>`
`git branch`
`git chechout <branch>`
`git add`
`git commit`
`git commit -m "commit message"` - быстрый коммит вместе с сообщением.
`git rm <filename>` - убрать файл из **staging** и так же удаляет его из рабочей директории.
`git rm --chached <filename>` - убирает файл из **staged** области но не удаляет его из рабочей дериктории. Файл перестает отслеживаться в гите.
`git mv` - копируети или переименовывает файл.


Сделать файл `.gitignore` для того чтобы GIT не ключал указанные файлы в коммиты. Файл может размещатяь в корневой папке проекта (где папка .git) или во вложенных папках для долее гибкой настройки.

Пример:
```sh
# ignore all .a files
*.a

# but do track lib.a, even though you're ignoring .a files above
!lib.a

# only ignore the TODO file in the current directory, not subdir/TODO
/TODO

# ignore all files in any directory named build
build/

# ignore doc/notes.txt, but not doc/server/arch.txt
doc/*.txt

# ignore all .pdf files in the doc/ directory and any of its subdirectories
doc/**/*.pdf
```

Примеры `gitignore` на [GitHub](https://github.com/github/gitignore)


 - `git status -s` - короткий статус

 - `git diff` - показввает конкретные изменения того, что изменено и не отправлено на **stage**.

 - `git diff --staged` - показывает разницу того, что изменено но **не закоммичено**.

 - `git log`  - 


Показывает разницу (-p,--patch)и выводит 2 последних коммита:
```sh
$ git log -p -2
```
Укороченный статус:
```sh
$ git log --stat
```
Форомат:
```sh
$ git log --pretty=format:"%h - %an, %ar : %s"
```
Граф + формат:
```sh
$ git log --pretty=format:"%h %s" --graph
```
За две последние недели:
```sh
$ git log --since=2.weeks
```
Имя изменяемой функции изменения в директории или файле:
```sh
$ git log -S function_name
$ git log -- path/to/file
```
ПРИМЕР:
```sh
$ git log --pretty="%h - %s" --author='Junio C Hamano' --since="2008-10-01" \
   --before="2008-11-01" --no-merges -- t/
```
## Откат изменений

`git commit --amend` - перезаписывает предыдущий коммит поверх не делая новой версии.
`git reset HEAD <file>` - возвращяат файл из области **staged**. файл лтслеживается как измененный но не внесенный на **strage** для коммита.

`git checkout -- <file>` - отменяет изменения в файле и восстанавливает его из репозитория.

> It’s important to understand that `git checkout -- <file>` is a **dangerous** command. Any local changes you made to that file are gone — Git just replaced that file with the last staged or committed version. Don’t ever use this command unless you absolutely know that you don’t want those unsaved local changes.

`git restore --staged` - возвращает файл со **stage**
`git restore <file>` - меняет содержимое фала в рабочей директории в его изначальное состояние.
> It’s important to understand that `git restore <file>` is a **dangerous** command. Any local changes you made to that file are gone — Git just replaced that file with the **last staged or committed version**. Don’t ever use this command unless you absolutely know that you don’t want those unsaved local changes.
