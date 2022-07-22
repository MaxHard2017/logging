# VIM commands

Интерактивный сайт по обучению [**Vim**](https://www.openvim.com/)

## Режимы

 - `i` - режим радактирования
 - `v` - визуальный режим
 - `**V**` - визуальный режим выделения строки
 - `Ctrl + v` - визуальный режим выделения блока
 - `Esc` - командный режим

### Команды в командном режиме (`Esc`)

 - `:w` - сохранить сделанные изменения
 - `:q` - выйти
 - `:q!` - выйти принудительно **без сохранения**
 - `:wq` - выйти с сохранением текущего файла

## Edits

Vim имеет собственную терминологию для копирования, вырезания и вставки. 
Копирование называется yank `y`, вырезание - delete `d`, а вставка - put `p`.

### Yanking - копирование

Чтобы скопировать текст, поместите курсор в нужное место и нажмите yклавишу, а затем команду перемещения. Ниже приведены некоторые полезные команды для восстановления:

 - `yy` - Копировать текущую строку, включая символ новой строки.
 - `3yy` - Снять (скопировать) три строки, начиная со строки, в которой находится курсор.
 - `y$` - Копировать  все от курсора до конца строки.
 - `y^` - Копировать  все от курсора до начала строки.
 - `yw` - Копировать в начало следующего слова.
 - `yiw` - Копировать текущее слово.
 - `y%` - Копировать на соответствующий символ. По умолчанию поддерживаются пары (), {} и []. Полезно для копирования текста в соответствующих скобках.

### Deleting - удаление

 В обычно мрежиме `d` это клавиша для вырезания (удаления) текста. 
 Переместите курсор в нужное положение и нажмите `d` клавишу, а затем команду
 перемещения. Вот некоторые полезные команды удаления:

 - `dd` - Удалить (вырезать) текущую строку, включая символ новой строки.
 - `3dd` - Удалить (вырезать) три строки, начиная со строки, в которой находится курсор.
 - `d$` - Удалить (вырезать) все от курсора до конца строки.

Команды перемещения, которые применяются для вырезки, также действительны для удаления. Например dw, удаляет до начала следующего слова и d^удаляет все от курсора до начала строки.

### Putting - вставка

Чтобы поместить выдернутый или удаленный текст, переместите курсор в нужное 
место и нажмите, `p` чтобы поместить (вставить) текст после курсора или **`P`**
чтобы поместить (вставить) перед курсором.

### Редактрирвание в визуальном режиме

 - Перейти в визуальный режим `v`, **`V`**, `Ctrl + v`.
 - `y` чтобы скопировать или, `d` чтобы вырезать выделение.
 - Переместите курсор в то место, куда вы хотите вставить содержимое.
 - **`P`** чтобы вставить содержимое перед курсором или `p` чтобы вставить его
после курсора.
