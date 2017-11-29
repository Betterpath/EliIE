FROM python:2.7
MAINTAINER brandon@betterpath.com
RUN apt-get update && \
    apt-get install -y openjdk-7-jdk && \
    apt-get install -y ant && \
    apt-get clean && \
    apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/
RUN pip install nltk networkx screen setuptools wheel
ENV LAST_UPDATED 2017-26-11
RUN pip install -e git+https://github.com/Betterpath/Pract-NLP-Tools.git#egg=practnlptools
RUN python -c "import nltk; nltk.download('punkt')"
RUN python -c "import nltk; nltk.download('averaged_perceptron_tagger')"
RUN mkdir /code
ADD Lib-SVM /code/Lib-SVM
WORKDIR /code/Lib-SVM
RUN make
WORKDIR /code/Lib-SVM/python
RUN make
ENV PATH /code/Lib-SVM/python:$PATH
ENV PYTHONPATH /code/Lib-SVM:/code/Lib-SVM/python:$PYTHONPATH
ARG S3_KEY
ARG S3_SECRET
ENV AWS_ACCESS_KEY_ID=${S3_KEY}
ENV AWS_SECRET_ACCESS_KEY=${S3_SECRET}
RUN mkdir -p /root/Tools/MetaMap
WORKDIR /root/Tools/MetaMap
ADD download.sh /root/Tools/MetaMap/download.sh
RUN ./download.sh
RUN tar xfj public_mm_linux_main_2016v2.tar.bz2
WORKDIR /root/Tools/MetaMap/public_mm
RUN ./bin/install.sh
ADD CRFPP /src/CRFPP
WORKDIR /src/CRFPP
RUN ./configure 
RUN make
WORKDIR /code
ENV PATH /src/CRFPP:$PATH
RUN pip install supervisor
ADD supervisord.conf /usr/local/etc/supervisord.conf
ENV LD_LIBRARY_PATH=/root/Tools/MetaMap/public_mm/WSD_Server/lib:/usr/lib:$LD_LIBRARY_PATH
ADD . /code
CMD supervisord
