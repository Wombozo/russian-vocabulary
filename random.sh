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

trap clear_exit INT

function clear_exit()
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
    echo -e "${ORANGE}$i) $line${NC}"
done

echo -e "\n${PURPLE}========================================================${NC}\n"

# Translating
function translate()
{
    again="true"
    echo -n -e "\033[1A\033[0K"
    while [ "$again" == "true" ]; do
        echo -n -e "\033[0K"
        echo -n -e "${BLUE}Which word do you want to translate ? (pick a number) : ${NC}"
        read -p "" number
        re='^[0-9]+$'
        if ! [[ $number =~ $re ]]; then
            echo -n -e "$number is not a number...\n"
        elif [ $number -gt $nb ] || [ $number -lt "1" ]; then
            echo -n -e "$number is not in range (1 to $nb)...\n"
        else
            fr=$(sed "${number}q;d" ${filename} | cut -d " " -f1)
            ru=$(sed "${number}q;d" ${filename} | cut -d " " -f2)
            echo -n -e "${number}) ${ORANGE}$fr${NC} is ${RED}$ru${NC}\n"
        fi
        echo -n -e "${GREEN}Again ? [Y/n] : ${NC}"
        read -p "" res
        case "$res" in
            [nN])
                again="false"
                ;;
            *)
                ;;
        esac
        echo -e "\033[1A\033[0K\033[1A\033[0K\033[1A\033[0K\033[1A"
    done
}

# Continue ?
read -r -p "$(echo -e ${RED}Randomly ask words or translate ? [R/t] :${NC}) " response
case "$response" in
    [tT])
        translate
        clear_exit
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
    echo -e "\033[1A\033[0K\033[2A"
done

