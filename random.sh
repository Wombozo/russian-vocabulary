#!/bin/bash

# Arg checking
if [ "$#" != "1" ] && [ "$#" != "2" ]; then
    echo "Please enter a filename"
    exit 1
fi

# Existence of dictionnary
if [ ! -e "$1" ]; then
    echo "Filename does not exist"
    exit 1
fi

filename=$1

# Number of lines of dictionnary
nb=$(wc -l $filename|cut -d " " -f1)

# If user wants to learn only few words
if [ "$#" == "2" ]; then
    re='^[0-9]+$'
    if ! [[ $2 =~ $re ]]; then
        echo "$2 is not a number !"
        exit 1;
    fi
    echo "Asking the first $2 words of $filename"
    if [ "$2" -lt "$nb" ]; then
        nb=$2
    fi
fi

echo "Press enter after every words to check, CTRL + C to exit"

BLUE='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

# Asking words
while true; do
    head -n $nb $filename>/tmp/dic
    line=$(shuf -n 1 "/tmp/dic")
    fr=$(echo $line|cut -d " " -f1)
    ru=$(echo $line|cut -d " " -f2)
    echo -e "${BLUE}$fr\c"
    read n
    echo -e "${GREEN}$ru${NC}\n"
done

