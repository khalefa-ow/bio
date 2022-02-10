step 1
	Command being timed: "cd-hit-est -i test_file.fasta -d 0 -o ./test_file.fasta.cd -c 0.95 -G 0 -n 9 -r 0 -g 1 -A 40 -p 1 -M 0 -T 10"
	User time (seconds): 3.05
	System time (seconds): 0.09
	Percent of CPU this job got: 160%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:01.96
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 52912
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 12393
	Voluntary context switches: 9
	Involuntary context switches: 3657
	Swaps: 0
	File system inputs: 0
	File system outputs: 4160
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
	

Step 3(1)	
	Command being timed: "RepeatMasker -pa 10 -s -lib ./arthro_ES_ND_PV_classified.fa -dir . -x test_file.fasta.cd"
	User time (seconds): 826.50
	System time (seconds): 6.08
	Percent of CPU this job got: 197%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 7:02.06
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 150640
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 629137
	Voluntary context switches: 3851
	Involuntary context switches: 200659
	Swaps: 0
	File system inputs: 0
	File system outputs: 488760
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0

Step 4	
	Command being timed: "RepeatProteinMask -engine ncbi test_file.fasta.cd.masked"
	User time (seconds): 523.49
	System time (seconds): 6.22
	Percent of CPU this job got: 108%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 8:09.61
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 150628
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 611808
	Voluntary context switches: 47059
	Involuntary context switches: 5182
	Swaps: 0
	File system inputs: 0
	File system outputs: 441656
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0	

Step 5
	Command being timed: "Rscript RAD_TE_summary.R test_file.fasta.cd.summary2 test_file.fasta.cd.out test_file.fasta.cd.masked.annot"
	User time (seconds): 3.18
	System time (seconds): 0.18
	Percent of CPU this job got: 100%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:03.37
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 262636
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 109840
	Voluntary context switches: 58
	Involuntary context switches: 51
	Swaps: 0
	File system inputs: 0
	File system outputs: 8
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0	

all
	Command being timed: "./TERAD1 test_file.fasta 10 ./arthro_ES_ND_PV_classified.fa none"
	User time (seconds): 1360.31
	System time (seconds): 12.69
	Percent of CPU this job got: 149%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 15:21.12
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 262636
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 1411904
	Voluntary context switches: 51702
	Involuntary context switches: 210202
	Swaps: 0
	File system inputs: 0
	File system outputs: 936360
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
