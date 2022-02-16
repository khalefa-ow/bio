# bio



docker build -t bio .

docker run --interactive --tty --entrypoint /bin/bash bio


###

https://stackoverflow.com/questions/774556/peak-memory-usage-of-a-linux-unix-process


##

docker run --interactive --tty -v /home/ubuntu/data/:/tmp/ --entrypoint /bin/bash bio
