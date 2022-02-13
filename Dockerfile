FROM ubuntu:18.04

MAINTAINER Basio

RUN set -ex &&\
   apt-get update && apt-get install -y \
    wget \
    unzip \
    build-essential\
    software-properties-common \
    git \
    cd-hit \
    python3-pip \
    libidn11 \ 
    time \
    vim \
    sysstat
    
RUN echo ' ENABLED="true" '  > /etc/default/sysstat
    
ENV RMBAST_TGZ http://www.repeatmasker.org/rmblast-2.11.0+-x64-linux.tar.gz
ENV REPEATMASKER_TGZ https://www.repeatmasker.org/RepeatMasker/RepeatMasker-4.1.2-p1.tar.gz 
ENV BLAST_TGZ ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.6.0/ncbi-blast-2.6.0+-x64-linux.tar.gz 
ENV DEBIAN_FRONTEND=noninteractive

# install R-script
ENV R_APT_KEY E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ${R_APT_KEY} && add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/' && apt update && apt install -y r-base
RUN R -e 'install.packages("readr");' && \
    R -e 'install.packages("plyr");' && \
    R -e 'install.packages("fitdistrplus");'
 
# Install TRF 
WORKDIR /usr/local/bin
RUN wget http://tandem.bu.edu/trf/downloads/trf407b.linux64 && mv trf*.linux64 trf && chmod +x trf

# Basic workdir
WORKDIR /usr/local
   
# Install Blast+
RUN wget ${BLAST_TGZ}  && \
    tar -xzvf ncbi-blast* && \
    find ncbi-blast* -type f -executable -exec mv {} bin \;

# Install RMBlast
RUN wget ${RMBAST_TGZ} && \
    tar -xzvf rmblast* && \
    mv rmblast*/bin/rmblastn bin 
    
# Install RepeatMasker
RUN wget ${REPEATMASKER_TGZ} \
    && tar -xzvf RepeatMasker*.tar.gz \
	&& rm -f RepeatMasker*.tar.gz 
RUN cd /usr/local/RepeatMasker && ./configure -trf_prgm /usr/local/bin/trf -rmblast_dir /usr/local/bin/ -default_search_engine rmblast 	

RUN pip3 install h5py
RUN pip3 install pandas

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/RepeatMasker

# Install TERAD
RUN git clone https://github.com/solomonchak/TERAD.git && cd TERAD && chmod +x TERAD &&\
    unzip arthro_ES_ND_PV*.zip
# Run TERAD
# RUN  cd TERAD && ./TERAD test_file.fasta 4 ./arthro_ES_ND_PV_classified.fa none

# I can't bundle the girinst RepBase libraries with the docker image,
# so you'll need to get them yourself. Download them from
# http://www.girinst.org/server/RepBase/protected/repeatmaskerlibraries/RepBaseRepeatMaskerEdition-20170127.tar.gz
#ONBUILD WORKDIR /usr/local/RepeatMasker
#ONBUILD ADD repeatmaskerlibraries.tar.gz /usr/local/RepeatMasker
#ONBUILD RUN cd /usr/local/RepeatMasker && util/buildRMLibFromEMBL.pl Libraries/RMRBSeqs.embl > Libraries/RepeatMasker.lib \
#		&& makeblastdb -dbtype nucl -in Libraries/RepeatMasker.lib > /dev/null 2>&1 \
#        && makeblastdb -dbtype prot -in Libraries/RepeatPeps.lib > /dev/null 2>&1

#ENTRYPOINT ["/usr/local/RepeatMasker/RepeatMasker"]

COPY TERAD1 TERAD
COPY install.sh TERAD
COPY convert.sh TERAD
COPY run.sh TERAD
RUN chmod +x TERAD/TERAD1 TERAD/*.sh
ENTRYPOINT ["/bin/bash"] 
