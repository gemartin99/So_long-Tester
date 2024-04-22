#!/bin/bash

# -=-=-=-=-	CLRS -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

DEF_COLOR='\033[0;39m'
BLACK='\033[0;30m'
RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[0;93m'
BLUE='\033[0;94m'
MAGENTA='\033[0;95m'
CYAN='\033[0;96m'
GRAY='\033[0;90m'
WHITE='\033[0;97m'

# -=-=-=-=-	CLRS -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

C=1;

#Function to check erroneous maps ↓


check_error_map() {

local map_file="$1"
local EXPECTED_OUTPUT="$2"

leaks --atExit -- ./so_long "$map_file" > /dev/null 2>&1
LEAKS=$?
if [ $LEAKS -eq 1 ]; then
        printf "${RED}$C.[MKO] LEAKS ${DEF_COLOR}"
else
        printf "${GREEN}$C.[MOK]${DEF_COLOR}";
fi

./so_long "$map_file" > test_check.txt

SO_LONG_EXIT_CODE=$?

LINE=$(head -n 1 test_check.txt)
LINE2=$(sed -n '2p' test_check.txt)

if [ $SO_LONG_EXIT_CODE == 139 ];then
        printf "${RED}[KO] SEGFAULT${DEF_COLOR}\n";
        ((C++))
        rm -rf test_check.txt
        return
fi


if [ $LINE == "Error" ];then
        printf "${GREEN}[OK] ${DEF_COLOR}";
        if [ -n "$LINE2" ];then
                if [ "${#LINE2}" -gt 1 ]; then
                        printf "${GRAY}\nExpected output: ${DEF_COLOR} $EXPECTED_OUTPUT \n"
                        printf "${GRAY}Your output: ${DEF_COLOR} $LINE2 \n"
                else
                        printf "${RED}[KO] You must display an explicit error message${DEF_COLOR}\n";
                        printf "${GRAY}Expected output: ${DEF_COLOR} $EXPECTED_OUTPUT \n"
                fi
        else
                printf "${RED}[KO] You must display an explicit error message${DEF_COLOR}\n";
                printf "${GRAY}Expected output: ${DEF_COLOR} $EXPECTED_OUTPUT \n"
        fi
else
        printf "${RED}[KO] Expected output: Error${DEF_COLOR}\n";

fi

((C++))
rm -rf test_check.txt
}

#Function to check erroneous maps ↑


#Function to check goods maps ↓

check_valid_map() {

local map_file="$1"

./so_long "$map_file" &

PID=$!

sleep 0.35

ps $PID > /dev/null

CHECK_ERROR=$?

if [ $CHECK_ERROR == 0 ]; then
    kill $PID > /dev/null 2>&1
    printf "${GREEN}$C.[OK] ${DEF_COLOR}\n";
    
else
    printf "${RED}$C.[KO] ${DEF_COLOR}\n";
fi

((C++))

rm -rf test_check.txt
}

#Function to check goods maps ↑

rm -rf traces.txt

FILE=$PWD/so_long
TEST=test_check.txt

if [ -f "$FILE" ]; then
	echo -n
else
	printf "${RED}NO EXIST SO_LONG PROGRAM ${DEF_COLOR}\n";
	exit 0
fi

if [ -z "$1" ]; then
echo -n
fi

#In all these cases your program should print an error and not run the game. ↓
#En todos estos casos tu programa debera printar error y no ejecutar el juego. ↓


leaks --atExit -- ./so_long > /dev/null 2>&1
LEAKS=$?
if [ $LEAKS -eq 1 ]; then
        printf "${RED}$C.[MKO] LEAKS ${DEF_COLOR}"
else
        printf "${GREEN}$C.[MOK]${DEF_COLOR}";
fi

./so_long > test_check.txt #1

LINE=$(head -n 1 test_check.txt)
LINE2=$(sed -n '2p' test_check.txt)

if [ $LINE == "Error" ];then
        printf "${GREEN}[OK] ${DEF_COLOR}";
        if [ -n "$LINE2" ];then
                if [ "${#LINE2}" -gt 1 ]; then
                        printf "${GRAY}\nExpected output: ${DEF_COLOR} Wrong number of arguments \n"
                        printf "${GRAY}Your output: ${DEF_COLOR} $LINE2 \n"
                else
                        printf "${RED}[KO] You must display an explicit error message${DEF_COLOR}\n";
                        printf "${GRAY}Expected output: ${DEF_COLOR} Wrong number of arguments \n"
                fi
        else
                printf "${RED}[KO] You must display an explicit error message${DEF_COLOR}\n";
                printf "${GRAY}Expected output: ${DEF_COLOR} Wrong number of arguments \n"
        fi
else
        printf "${RED}[KO] Expected output: Error${DEF_COLOR}\n";

fi

((C++))
rm -rf test_check.txt

leaks --atExit -- ./so_long invent.ber more argv > /dev/null 2>&1
LEAKS=$?
if [ $LEAKS -eq 1 ]; then
        printf "${RED}$C.[MKO] LEAKS ${DEF_COLOR}"
else
        printf "${GREEN}$C.[MOK]${DEF_COLOR}";
fi

./so_long invent.ber more argv > test_check.txt #2

LINE=$(head -n 1 test_check.txt)
LINE2=$(sed -n '2p' test_check.txt)

if [ $LINE == "Error" ];then
        printf "${GREEN}[OK] ${DEF_COLOR}";
        if [ -n "$LINE2" ];then
                if [ "${#LINE2}" -gt 1 ]; then
                        printf "${GRAY}\nExpected output: ${DEF_COLOR} Wrong number of arguments \n"
                        printf "${GRAY}Your output: ${DEF_COLOR} $LINE2 \n"
                else
                        printf "${RED}[KO] You must display an explicit error message${DEF_COLOR}\n";
                        printf "${GRAY}Expected output: ${DEF_COLOR} Wrong number of arguments \n"
                fi
        else
                printf "${RED}[KO] You must display an explicit error message${DEF_COLOR}\n";
                printf "${GRAY}Expected output: ${DEF_COLOR} Wrong number of arguments \n"
        fi
else
        printf "${RED}[KO] Expected output: Error${DEF_COLOR}\n";

fi

((C++))
rm -rf test_check.txt

touch maps_err/permis.ber
chmod 000 maps_err/permis.ber
check_error_map "maps_err/permis.ber" "Permission denied" #3
rm -rf maps_err/permis.ber
check_error_map "invent.ber" "No exist map" #4
check_error_map "maps_err/badextension1.txt" "Bad extension" #5
check_error_map "maps_err/badextension2.ber.txt" "Bad extension" #6
check_error_map "maps_err/badextension3.bber" "Bad extension" #7
check_error_map "maps_err/.ber" "Bad extension" #8 Hidden file, not extension ber
check_error_map "maps_err/no_rectangular.ber" "No rectangular" #9
check_error_map "maps_err/no_rectangular1.ber" "No rectangular" #10
check_error_map "maps_err/no_rectangular2.ber" "No rectangular" #11
check_error_map "maps_err/no_rectangular3.ber" "No rectangular" #12
check_error_map "maps_err/no_rectangular4.ber" "No rectangular" #13
check_error_map "maps_err/no_rectangular5.ber" "No rectangular" #14
check_error_map "maps_err/no_rectangular6.ber" "No rectangular" #15
check_error_map "maps_err/no_rectangular7.ber" "No rectangular" #16
check_error_map "maps_err/no_rectangular8.ber" "No rectangular" #17
check_error_map "maps_err/no_rectangular9.ber" "No rectangular" #18
check_error_map "maps_err/no_player.ber" "No player" #19
check_error_map "maps_err/no_exit.ber" "No exit" #20
check_error_map "maps_err/no_object.ber" "No object" #21
check_error_map "maps_err/duplicate_player.ber" "Duplicate player" #22
check_error_map "maps_err/duplicate_exit.ber" "Duplicate exit" #23
check_error_map "maps_err/no_valid_road.ber" "Duplicate exit" #24
check_error_map "maps_err/no_valid_road1.ber" "Duplicate exit" #25
check_error_map "maps_err/no_valid_road2.ber" "Duplicate exit" #26
check_error_map "maps_err/no_valid_road3.ber" "Duplicate exit" #27
check_error_map "maps_err/no_valid_road4.ber" "Duplicate exit" #28
check_error_map "maps_err/no_valid_road5.ber" "Duplicate exit" #29
check_error_map "maps_err/no_valid_road6.ber" "Duplicate exit" #30
check_error_map "maps_err/no_valid_road7.ber" "Duplicate exit" #31
check_error_map "maps_err/no_valid_road8.ber" "Duplicate exit" #32
check_error_map "maps_err/no_valid_road9.ber" "Duplicate exit" #33
check_error_map "maps_err/no_valid_road10.ber" "Duplicate exit" #34
check_error_map "maps_err/no_walls.ber" "Not surrounded by walls" #35
check_error_map "maps_err/no_walls1.ber" "Not surrounded by walls" #36
check_error_map "maps_err/no_walls2.ber" "Not surrounded by walls" #37
check_error_map "maps_err/no_walls3.ber" "Not surrounded by walls" #38
check_error_map "maps_err/no_walls4.ber" "Not surrounded by walls" #39
check_error_map "maps_err/no_walls5.ber" "Not surrounded by walls" #40
check_error_map "maps_err/no_walls6.ber" "Not surrounded by walls" #41
check_error_map "maps_err/no_walls7.ber" "Not surrounded by walls" #😍42😍
check_error_map "maps_err/no_walls8.ber" "Not surrounded by walls" #43
check_error_map "maps_err/no_walls9.ber" "Not surrounded by walls" #44
check_error_map "maps_err/wrong_chars.ber" "Wrong characters" #45
check_error_map "maps_err/wrong_chars1.ber" "Wrong characters" #46
check_error_map "maps_err/wrong_chars2.ber" "Wrong characters" #47
check_error_map "maps_err/wrong_chars3.ber" "Wrong characters" #48
check_error_map "maps_err/wrong_chars4.ber" "Wrong characters" #49
check_error_map "maps_err/wrong_chars5.ber" "Wrong characters" #50
check_error_map "maps_err/no_valid_road11.ber" "Duplicate exit" #51
check_error_map "maps_err/no_valid_road12.ber" "Duplicate exit" #52
check_error_map "maps_err/no_valid_road13.ber" "Duplicate exit" #53
check_error_map "maps_err/no_valid_road14.ber" "Duplicate exit" #54
check_error_map "maps_err/no_valid_road15.ber" "Duplicate exit" #55

#In all these cases your program should run normally and not show any errors. ↓ In these cases, memory leaks are not checked, so I recommend that you check them by hand.
#En todos estos casos tu programa deberá ejecutarse con normalidad y no mostrar ningun error ↓ En estos casos no se comprueban los leaks de memoria asique te recomiendo revisarlos a mano

check_valid_map "maps_valid/ok.ber" #56
check_valid_map "maps_valid/ok1.ber" #57
check_valid_map "maps_valid/ok2.ber" #58
check_valid_map "maps_valid/ok3.ber" #59
check_valid_map "maps_valid/ok4.ber" #60
check_valid_map "maps_valid/ok5.ber" #61
check_valid_map "maps_valid/ok6.ber" #62
check_valid_map "maps_valid/ok7orok.ber" #63🐙
check_valid_map "maps_valid/ok8.ber" #64
check_valid_map "maps_valid/ok9.ber" #65
check_valid_map "maps_valid/ok10.ber" #66
check_valid_map "maps_valid/ok11.ber" #67
check_valid_map "maps_valid/ok12.ber" #68
check_valid_map "maps_valid/ok13.ber" #69
check_valid_map "maps_valid/ok14.ber" #70
check_valid_map "maps_valid/ok15.ber" #71