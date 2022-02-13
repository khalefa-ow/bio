#!/bin/bash

rm -f *.tmp
FILE=${1?Error: No filename given.}
CORE=${2?Error: No core given.}
echo "file: $FILE"
echo "core; $CORE"

/usr/bin/time -v --output=all.tmp ./TERAD1 $FILE $CORE ./arthro_ES_ND_PV_classified.fa none

./combine.sh > test.tmp
rm -f f.csv
[ -f test.tmp ] && python3 convert.py

[ -f f.csv ] && rm -f *.tmp

mv f.csv process_${FILE}__${CORE}.csv


