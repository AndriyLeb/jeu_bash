#!/bin/bash

source ./config &>/dev/null



read -p "Enter your name: "$'\n' name;

if [ ${#name} -gt $max_characters_in_name ]; then
    echo "max $max_characters_in_name characters"
    exit 1
fi

echo "choose a level of difficulty: 1 2 or 3"
read difficulty;

if [ $difficulty -gt 3 ] || [ $difficulty -lt 1 ];then
    echo "There are only 3 levels of difficulty"
    exit 2
fi

# Ici j'aimerai aussi tester si $difficuly est un nombre mais comme; voir ligne 60

if [ $difficulty -eq 1 ];then
    var_rand=$(( $RANDOM % 100 ))
    max=99
    max_tries=10
fi

if [ $difficulty -eq 2 ];then
    var_rand=$(( $RANDOM % 500 ))
    max=499
    max_tries=20
fi

if [ $difficulty -eq 3 ];then
    var_rand=$(( $RANDOM % 1000 ))
    max=999
    max_tries=50
fi

if [ $# -ne 0 ]; then
    echo "expexting 0 arguments, got $#"
    exit 1
fi

start=$( date +%s )

while true; do

    if [ $var_try -gt $max_tries ];then
        echo "Looser, max $max_tries tires"
        exit 3
    fi  

    echo "Enter a number between 0 and $max"
    read number;

# Renvoi la bonne erreur quand l'utilisateur rentre une valeur qui n'est pas un entier
# mais aussi quand c'est un entier. Je n'ai pas trouvé de solutions

#    if ! [ $number -n ] &>/dev/null; then     "-n" renvoi une erreur par defaut si la condition n'est pas respecté. On utilise "&>/dev/null" pour avoir son propre message d'erreur
#       echo "$number Must be a number"
#       exit 3
#    fi

    if [ $number -gt $max ] || [ $number -lt 0 ]; then
        echo "number must be between 0 & $max"
        exit 4
    fi

    if [ $number -eq $var_rand ]; then
        let "var_try = var_try + 1"
        end=$( date +%s )
        let "res = end - start"
        echo "Congrats $name, you won in $var_try tries and $res seconds"

#gestion de difficulté

        if [ $difficulty -eq 1 ]; then

        if [ $(wc -l LEADERBOARDS/LEADERBOARD_lvl1.txt | cut -d' ' -f1) -gt $max_spots_in_leaderboard ];then
            echo "The leaderboard is full"
            exit 5
        fi

            echo "$name: $var_try tries & $res second(s)" >> LEADERBOARDS/LEADERBOARD_lvl1.txt
            sort -k5 -k2 -no LEADERBOARDS/LEADERBOARD_lvl1.txt LEADERBOARDS/LEADERBOARD_lvl1.txt                     #Double tri. D'abbord par temps, puis par nombre d'essais s'il y a égalité            
            i=1
            while IFS= read -r line; do
                echo "Rank$i => $line"
                let "i = i+1"
            done < LEADERBOARDS/LEADERBOARD_lvl1.txt
            exit 0                                                              
        fi

        if [ $difficulty -eq 2 ]; then

        if [ $(wc -l LEADERBOARDS/LEADERBOARD_lvl2.txt | cut -d' ' -f1) -gt $max_spots_in_leaderboard ];then
            echo "The leaderboard is full"
            exit 5
        fi

            echo "$name: $var_try tries & $res second(s)" >> LEADERBOARDS/LEADERBOARD_lvl2.txt
            sort -k5 -k2 -no LEADERBOARDS/LEADERBOARD_lvl2.txt LEADERBOARDS/LEADERBOARD_lvl2.txt                               
            i=1
            while IFS= read -r line; do
                echo "Rank$i => $line"
                let "i = i+1"
            done < LEADERBOARDS/LEADERBOARD_lvl2.txt
            exit 0                                                              
        fi       

        if [ $difficulty -eq 3 ]; then

        if [ $(wc -l LEADERBOARDS/LEADERBOARD_lvl3.txt | cut -d' ' -f1) -gt $max_spots_in_leaderboard ];then
            echo "The leaderboard is full"
            exit 5
        fi

            echo "$name: $var_try tries & $res second(s)" >> LEADERBOARDS/LEADERBOARD_lvl3.txt
            sort -k5 -k2 -no LEADERBOARDS/LEADERBOARD_lvl3.txt LEADERBOARDS/LEADERBOARD_lvl3.txt                               
            i=1
            while IFS= read -r line; do
                echo "Rank$i => $line"
                let "i = i+1"
            done < LEADERBOARDS/LEADERBOARD_lvl3.txt
            exit 0                                                              
        fi
    fi

    if [ $number -gt $var_rand ]; then
        echo "lower";
        let "var_try = var_try + 1"
    fi

    if [ $number -lt $var_rand ]; then
        echo "highter"
        let "var_try = var_try + 1"
    fi
done