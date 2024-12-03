#!/bin/bash
#Создание папок и файлов
if [[ $1 == "t1" ]]; then
    mkdir lab0
    cd lab0


    mkdir exploud4
    touch exploud4/hitmountop
    mkdir exploud4/linoone
    touch exploud4/cleffa
    touch exploud4/staravia
    touch exploud4/ferroseed

    mkdir gothitelle6
    mkdir gothitelle6/teddiursa
    touch gothitelle6/bronzong
    touch gothitelle6/bonsly
    mkdir gothitelle6/oddish
    mkdir gothitelle6/marowak
    touch gothitelle6/glavantula

    mkdir hitmonchan6
    touch hitmonchan6/wigglytuff
    mkdir hitmonchan6/hippowdon
    touch hitmonchan6/whismur

    touch sunflora2
    touch swellow8
    touch zorua0

    #hitmontop:
    echo Xоды Body Slam Covet Double-Edge Drill Run Endeavor >> exploud4/hitmountop
    echo Helping Hand Low Kick Magic Coat Mega Kick Mud-Slap Revenge‡ Role Play >> exploud4/hitmountop
    echo Rolling Kick‡ Seismic Toss Sleep Talk Snore Sucker Punch Swift Twister >> exploud4/hitmountop
    echo Vacuum Wave >> exploud4/hitmountop

    #cleffa
    echo Xоды After You Body Slam Counter Covet Defense Curl Double-Edge Endeavor Gravity Helping Hand Hyper Voice Icy Wind Iron Tail Last Resort Magic Coat Mega Kick Mega Punch Mud-Slap Recycle Role Play Rollout Seismic Toss Shock Wave Signal Beam Sleep Talk Snore Softboiled Trick Uproar Water Pulse Wonder Room Zen >> exploud4/cleffa
    echo Headbutt >> exploud4/cleffa

    #staravia
    echo Тип покемона NORMAL FLYING >> exploud4/staravia

    #ferroseed
    echo Ходы >> exploud4/ferroseed
    echo Endeavor Giga Drain Gravity Iron Defense Iron Head Magnet Rise Seed Bomb Sleep Talk Snore Stealth Rock Worry Seed >> exploud4/ferroseed

    #bronzong
    echo Тип диеты Nullivore >> gothitelle6/bronzong

    #bonsly
    echo Способности Copycat Fake Tears Flail Low Kick Rock >> gothitelle6/bonsly
    echo Throw Slam Faint Attack Rock Tomb Block Rock Slide Mimic Sucker Punch Double-Edge >> gothitelle6/bonsly

    #galvantula
    echo Тип покемона BUG ELECTRIC >> gothitelle6/glavantula

    #wigglytuff
    echo satk=8 >> hitmonchan6/wigglytuff
    echo sdef 5 spd=5 >> hitmonchan6/wigglytuff

    #whismur
    echo Xод Body Slam Counter Defense Curl Double-Edge >> hitmonchan6/whismur
    echo Dynamicpunch Fire Punch Hyper Voice Ice Punch Icy Wind Mega Kick Mega Punch Mud-Slap Psych Up Rollout Seismic Toss Shock Wave Sleep Talk Snore Thunderpunch Uproar Water Pulse Zen >> hitmonchan6/whismur
    echo Headbutt >> hitmonchan6/whismur

    #sunflora2
    echo weigth=18.7 height=31.0 atk=8 >> sunflora2
    echo def=6 >> sunflora2

    #swellow8
    echo Живет Forest Grassland >> swellow8

    #zorua0
    echo satk=8 sdef=4 spd=7 >> zorua0
    fi

if [[ $1 == "t2" ]]; then
    cd lab0
    chmod 737 exploud4
    chmod 440 exploud4/hitmountop
    chmod 524 exploud4/linoone
    chmod 006 exploud4/cleffa
    chmod 444 exploud4/staravia
    chmod 046 exploud4/ferroseed
    chmod 315 gothitelle6
    chmod 355 gothitelle6/teddiursa
    chmod 404 gothitelle6/bronzong
    chmod 044 gothitelle6/bonsly
    chmod 513 gothitelle6/oddish
    chmod 375 gothitelle6/marowak
    chmod 004 gothitelle6/glavantula
    chmod 513 hitmonchan6
    chmod 044 hitmonchan6/wigglytuff
    chmod 612 hitmonchan6/hippowdon
    chmod 404 hitmonchan6/whismur
    chmod 440 sunflora2
    chmod 622 swellow8
    chmod 004 zorua0
fi

if [[ $1 == "t3fix" ]]; then
    cd lab0
    chmod u+r exploud4/ferroseed
    chmod u+w gothitelle6/oddish
    chmod u+w sunflora2
    chmod u+w hitmonchan6
    chmod u+r exploud4/cleffa
fi

if [[ $1 == "t3" ]]; then
    cd lab0
    ln sunflora2 gothitelle6/galvantulasunflora
    ln -s hitmonchan6 Copy_91
    cat exploud4/ferroseed > swellow8_19
    cat gothitelle6/bronzong >> swellow8_19
    cp swellow8 gothitelle6/oddish
    cat sunflora2 > gothitelle6/galvantulasunflora
    ln -s ../zorua0 hitmonchan6/whismurzorua
    cp -r exploud4 gothitelle6/teddiursa

fi

if [[ $1 == "t4" ]]; then
    cd lab0

    #1
    wc -l hitmonchan6/*  2>&1 | head -n -1 | sort -n -r
    echo

    #2
    ls -lR 2> /dev/null -r -t -w 20 | grep "^[^\.t][^>]*6$"
    echo

    #3
    chmod u+r gothitelle6/bonsly gothitelle6/glavantula hitmonchan6/wigglytuff 
    cat -n gothitelle6/bonsly 2>/dev/null | grep 'd$'
    cat -n gothitelle6/glavantula 2>/dev/null | grep 'd$'
    cat -n hitmonchan6/wigglytuff 2>/dev/null | grep 'd$'
    echo

    #4
    ls -lR 2>/tmp/lab_task | head -n 6 | tail -n 4 | sort -t ' ' -k8
    echo

    #5
    cat swellow8 2>&1 | grep 'sde'
    echo

    #6
    find $PWD -type f -name "*a" -exec cat -n {} \; | sort -t $'\t' -k2    
    echo
fi

if [[ $1 == "t5fix" ]]; then
    cd lab0
    chmod u+w sunflora2
    chmod u+r hitmonchan6
    chmod u+r gothitelle6
    chmod u+w gothitelle6/glavantula
    chmod 733 exploud4 &&  chmod -R u+w exploud4
fi

if [[ $1 == "t5" ]]; then
    cd lab0
    rm sunflora2
    rm gothitelle6/glavantula
    rm hitmonchan6/whismurzor*
    rm gothitelle6/galvantulasunflo*
    rmdir exploud4/linoone
    rm -r exploud4
fi

if [[ $1 == "rem" ]]; then
    rm -r lab0
fi

