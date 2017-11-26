FROM python:2.7
MAINTAINER brandon@betterpath.com
RUN pip install nltk networkx
ENV LAST_UPDATED 2017-26-11
RUN pip install --upgrade pip setuptools wheel
RUN pip install -e git+https://github.com/Betterpath/Lib-SVM-Python.git#egg=libsvm-python
RUN pip install -e git+https://github.com/Betterpath/Pract-NLP-Tools.git#egg=practnlptools
RUN mkdir /code
WORKDIR /code
ADD . /code
CMD tail -f /dev/null
