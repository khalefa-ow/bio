FROM ubuntu:18.04

MAINTAINER Basio

RUN set -ex &&\
   apt-get update && apt-get install -y \
    wget \
    unzip \
    build-essential\
    software-properties-common

# Install TRF 
WORKDIR /usr/local/bin
RUN wget http://tandem.bu.edu/trf/downloads/trf407b.linux64 && mv trf*.linux64 trf && chmod +x trf

# Basic workdir
WORKDIR /usr/local

# Install RMBlast
RUN wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/rmblast/2.2.28/ncbi-rmblastn-2.2.28-x64-linux.tar.gz && \
    tar -xzvf ncbi-rmblastn* && \
    rm ncbi-rmblastn*.tar.gz && \
    mv ncbi-rmblastn*/bin/rmblastn bin && \
    rm -rf ncbi-rmblastn    
    
# Install RepeatMasker
RUN wget http://www.repeatmasker.org/RepeatMasker-open-4-0-7.tar.gz \
    && tar -xzvf RepeatMasker-open*.tar.gz \
	&& rm -f RepeatMasker-open*.tar.gz \
	&& perl -0p -e 's/\/usr\/local\/hmmer/\/usr\/bin/g;' \
	-e 's/\/usr\/local\/rmblast/\/usr\/local\/bin/g;' \
    -e 's/DEFAULT_SEARCH_ENGINE = "crossmatch"/DEFAULT_SEARCH_ENGINE = "ncbi"/g;' \
    -e 's/TRF_PRGM = ""/TRF_PRGM = "\/usr\/local\/bin\/trf"/g;' RepeatMasker/RepeatMaskerConfig.tmpl > RepeatMasker/RepeatMaskerConfig.pm
    
# Fix RepeatMasker's strange shebang lines
RUN cd /usr/local/RepeatMasker \
	&& perl -i -0pe 's/^#\!.*perl.*/#\!\/usr\/bin\/env perl/g' \
	RepeatMasker \
    DateRepeats \
    ProcessRepeats \
    RepeatProteinMask \
    DupMasker \
    util/queryRepeatDatabase.pl \
    util/queryTaxonomyDatabase.pl \
    util/rmOutToGFF3.pl \
    util/rmToUCSCTables.pl
# I can't bundle the girinst RepBase libraries with the docker image,
# so you'll need to get them yourself. Download them from
# http://www.girinst.org/server/RepBase/protected/repeatmaskerlibraries/RepBaseRepeatMaskerEdition-20170127.tar.gz

ONBUILD WORKDIR /usr/local/RepeatMasker
ONBUILD ADD repeatmaskerlibraries.tar.gz /usr/local/RepeatMasker
ONBUILD RUN cd /usr/local/RepeatMasker && util/buildRMLibFromEMBL.pl Libraries/RMRBSeqs.embl > Libraries/RepeatMasker.lib \
		&& makeblastdb -dbtype nucl -in Libraries/RepeatMasker.lib > /dev/null 2>&1 \
        && makeblastdb -dbtype prot -in Libraries/RepeatPeps.lib > /dev/null 2>&1

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/RepeatMasker:/usr/local/RepeatScout:/usr/local/recon/bin:/usr/local/RepeatModeler
#ENTRYPOINT ["/usr/local/RepeatMasker/RepeatMasker"]
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y cd-hit
ENV R_APT_KEY E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ${R_APT_KEY} && add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/' && apt update && apt install -y r-base

RUN R -e 'install.packages("readr");' && \
    R -e 'install.packages("plyr");' && \
    R -e 'install.packages("fitdistrplus");'

ENTRYPOINT ["/bin/bash"] 
