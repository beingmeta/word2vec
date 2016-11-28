#!/bin/sh

EXE_DIR=
ROOT_DIR=

if readlink $0 2>&1 > /dev/null; then
    LINK_TARGET=`readlink $0`;
    EXE_DIR=`dirname ${LINK_TARGET}`;
else
    EXE_DIR=`dirname $0`;
fi;

for dir in . .. ${EXE_DIR}/.. ${EXE_DIR}; do
    if test -d ${dir}/data &&
       test -d ${dir}/bin &&
       test -d ${dir}/src &&
       test -d ${dir}/data; then
	ROOT_DIR=${dir}; break;
    fi;
done;

DATA_DIR="${ROOT_DIR}/data"
BIN_DIR="${ROOT_DIR}/bin"
SRC_DIR="${ROOT_DIR}/src"

TEXT_DATA="${DATA_DIR}/text8"
PHRASES_DATA="${DATA_DIR}/text8-phrases"
PHRASES_VECTOR_DATA="${DATA_DIR}/vectors-phrase.bin"
ZIPPED_TEXT_DATA="${TEXT_DATA}.zip"
VECTOR_DATA="${DATA_DIR}/text8-vector.bin"
CLASSES_DATA="$DATA_DIR/classes.txt"

if test "${ROOT_DIR}" = ".." ||  \
   test "${ROOT_DIR}" = "." ||   \
   test ! -x "${BIN_DIR}/word2vec"; then \
    make -C ${SRC_DIR};
fi;

if [ ! -e ${CLASSES_DATA} ]; then
  
  if [ ! -e ${TEXT_DATA} ]; then
    wget http://mattmahoney.net/dc/text8.zip -O ${DATA_DIR}/text8.gz
    gzip -d ${DATA_DIR}/text8.gz -f
  fi
  echo -----------------------------------------------------------------------------------------------------
  echo -- Training vectors...
  time ${BIN_DIR}/word2vec -train ${TEXT_DATA} -output ${CLASSES_DATA} -cbow 0 -size 200 -window 5 -negative 0 -hs 1 -sample 1e-3 -threads 12 -classes 500
  
fi

sort ${CLASSES_DATA} -k 2 -n > ${DATA_DIR}/classes.sorted.txt
echo The word classes were saved to file ${DATA_DIR}/classes.sorted.txt
