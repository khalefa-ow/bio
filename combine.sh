#!/bin/bash

printf "\n step: 1 \n"
[ -f s1.tmp ] && cat s1.tmp
printf "\n step: 3 \n"
[ -f s31.tmp ] && cat s31.tmp
[ -f s32.tmp ] && cat s32.tmp
printf "\n step: 4 \n"
[ -f s4.tmp ] && cat s4.tmp
printf "\n step: 5 \n"
[ -f s5.tmp ] && cat s5.txt
printf '\n step: "all" \n'
[ -f all.tmp ] && cat all.tmp
