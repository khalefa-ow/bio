"/usr/bin/cd-hit-est -i $FILE -d 0 -o ./"${FILE}".cd -c 0.95 -G 0 -n 9 -r 0 -g 1 -A 40 -p 1 -M 0 -T $CORE"

 pidstat -t -C "/usr/bin/cd-hit-est -i /usr/local/TERAD/test_file.fasta -d 0 -o /usr/local/TERAD/test_file.fasta.cd -c 0.95 -G 0 -n 9 -r 0 -g 1 -A 40 -p 1 -M 0 -T 2"

./TERAD test_file.fasta 4 ./arthro_ES_ND_PV_classified.fa none

pidstat -t -T CHILD 1 -e ./TERAD1 test_file.fasta 4 ./arthro_ES_ND_PV_classified.fa none

/usr/bin/time -v --output=out.txt ./TERAD1 test_file.fasta 4 ./arthro_ES_ND_PV_classified.fa none

./TERAD1 test_file.fasta 4 ./arthro_ES_ND_PV_classified.fa none
