FROM python:2.7
MAINTAINER brandon@betterpath.com
RUN pip install nltk networkx
ENV LAST_UPDATED 2017-26-11
RUN pip install --upgrade pip setuptools wheel
RUN pip install -e git+https://github.com/Betterpath/Pract-NLP-Tools.git#egg=practnlptools
RUN pip install screen
RUN python -c "import nltk; nltk.download('punkt')"
run python -c "import nltk; nltk.download('averaged_perceptron_tagger')"
RUN mkdir /code
ADD . /code
WORKDIR /code/Lib-SVM
RUN make
WORKDIR /code/Lib-SVM/python
RUN make
ENV PATH /code/Lib-SVM/python:$PATH
ENV PYTHONPATH /code/Lib-SVM:/code/Lib-SVM/python:$PYTHONPATH
WORKDIR /code
CMD tail -f /dev/null
