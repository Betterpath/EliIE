#!/bin/bash
# author: Tian Kang (tk2624@cumc.columbia.edu)

# Simple wrapper for the eligibility criteria parser.
# Before running the parser, please change the @arguements to your personal dir and files
#
# NOTE: this script assumes MetaMap is installed and requires that
# the MetaMap support services are running. If you have
# MetaMap installed in $MM, these can be started as
#
#    $MM/bin/skrmedpostctl start
#    $MM/bin/wsdserverctl start
#
# Required python pacakage:
#   nltk suites
#   networkx
#   codecs
#   libsvm  (https://www.csie.ntu.edu.tw/~cjlin/libsvm , https://github.com/cjlin1/libsvm/tree/master/python)
#   practnlptools   (https://pypi.python.org/pypi/practnlptools/1.0)

INPUT_DIR='output'
INPUT_TEXT='test.txt'
OUTPUT_DIR='output'

python NamedEntityRecognition.py $INPUT_DIR $INPUT_TEXT $OUTPUT_DIR
echo "Named Entity Recognition Finished!"
python Relation.py $OUTPUT_DIR $INPUT_TEXT
echo "Parsing Finished!"
