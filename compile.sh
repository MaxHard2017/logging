#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No file to compile with gcc"
    echo "Enter file name"
    exit 1
fi

PATH=~/coding/MinGWx86_64-8.1.0/mingw64/bin
gcc $1 -Wall -Werror -Wextra


