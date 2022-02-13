#!/bin/bash

FILE=${1?Error: No filename given.}
CORE=${2?Error: No core given.}
/usr/bin/time -v --output=all.txt ./TERAD1 $FILE $CORE ./arthro_ES_ND_PV_classified.fa none
