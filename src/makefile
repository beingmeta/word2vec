SCRIPTS_DIR=../scripts
BIN_DIR=../bin

CC = gcc
#The -Ofast might not work with older versions of gcc; in that case, use -O2
CFLAGS = -lm -pthread -O2 -Wall -funroll-loops -Wno-unused-result

all: word2vec word2phrase distance word-analogy compute-accuracy scripts

%: %.c
	$(CC) $< -o $@ $(CFLAGS)
	cp $@ ${BIN_DIR}/$@
scripts:
	chmod +x ${SCRIPTS_DIR}/*.sh

clean:
	rm -rf word2vec word2phrase distance word-analogy compute-accuracy
	cd ${BIN_DIR} && rm -rf word2vec word2phrase distance word-analogy compute-accuracy
