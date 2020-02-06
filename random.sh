#!/bin/bash

# RANDOM DICTIONNARY GENERATOR

BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[0;31m'
ORANGE='\033[0;33m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

clear
echo -e "${PURPLE}=============================================${NC}"
echo -e "${RED}Welcome to the random dictionnary generator !${RED}"
echo -e "${PURPLE}=============================================${NC}\n"

function help()
{
    echo -e "Usage : $0 filename [first lines]\n\nExamples: \n\t$0 ./dictionnary1\n\t$0 ./dictionnary1 5\n"
}

trap ctrl_c INT

function ctrl_c()
{
    clear
    exit 0
}

# Arg checking
if [ "$#" != "1" ] && [ "$#" != "2" ]; then
    help
    exit 1
fi

# Existence of dictionnary
if [ ! -e "$1" ]; then
    help
    echo "=> Filename does not exist"
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
    if [ "$2" -lt "$nb" ]; then
        nb=$2
    fi
fi

# Listing words
for (( i=1; i<=$nb; i++)); do
    line=$(sed "${i}q;d" ${filename} | cut -d " " -f1)
    echo -e ${ORANGE}$line${NC}
done

echo -e "\n${PURPLE}========================================================${NC}\n"

# Continue ?
read -r -p "$(echo -e ${RED}Continue with these words ? [Y/n] :${NC}) " response
case "$response" in
    [nN])
        exit 0
        ;;
    *)
        ;;
esac

echo -e "\nPress enter after every words to check, CTRL + C to exit !\n"
echo -e -n "\n\n\n\n\n${PURPLE}========================================================${NC}"
echo -e -n "\033[4A \r"

# Asking words
while true; do
    head -n $nb $filename>/tmp/dic
    line=$(shuf -n 1 "/tmp/dic")
    fr=$(echo $line|cut -d " " -f1)
    ru=$(echo $line|cut -d " " -f2)
    echo -e -n "\033[0K${BLUE}$fr${NC} "
    read n
    echo -e -n "${GREEN}=> $ru${NC}"
    read n
#    if [ "n" -eq ^[-]]
    echo -e "\033[1A\033[0K\033[2A"
done

