#!/bin/bash

sudo  apt-get update && sudo apt-get install -y \
    wget \
    unzip \
    build-essential\
    software-properties-common \
    git \
    cd-hit \
    python3-pip \
    libidn11

pip3 install h5py

RMBAST_TGZ=http://www.repeatmasker.org/rmblast-2.11.0+-x64-linux.tar.gz
REPEATMASKER_TGZ=https://www.repeatmasker.org/RepeatMasker/RepeatMasker-4.1.2-p1.tar.gz 
BLAST_TGZ=ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.6.0/ncbi-blast-2.6.0+-x64-linux.tar.gz 
DEBIAN_FRONTEND=noninteractive
R_APT_KEY=E298A3A825C0D65DFD57CBB651716619E084DAB9

sudo  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ${R_APT_KEY} &&  sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/' && sudo apt update && sudo apt install -y r-base
sudo R -e 'install.packages("readr");' && \
    sudo R -e 'install.packages("plyr");' && \
    sudo R -e 'install.packages("fitdistrplus");'

sudo chown ubunut:ubuntu /usr/local/bin/

cd /usr/local/bin

 wget http://tandem.bu.edu/trf/downloads/trf407b.linux64 && mv trf*.linux64 trf && chmod +x trf
cd /usr/local/bin
 wget ${BLAST_TGZ}  && \
    tar -xzvf ncbi-blast* && \
    find ncbi-blast* -type f -executable -exec mv {} bin \;    

    cd /usr/local/bin
 wget ${RMBAST_TGZ} && \
    tar -xzvf rmblast* && \
    mv rmblast*/bin/rmblastn bin     

    cd /usr/local/bin
wget ${REPEATMASKER_TGZ} \
    && tar -xzvf RepeatMasker*.tar.gz \
	&& rm -f RepeatMasker*.tar.gz 
 cd /usr/local/bin/RepeatMasker && ./configure -trf_prgm /usr/local/bin/trf -rmblast_dir /usr/local/bin/ -default_search_engine rmblast 	


PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin/RepeatMasker
