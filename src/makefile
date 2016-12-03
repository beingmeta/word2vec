SCRIPTS_DIR=../scripts
BIN_DIR=../bin

CC = gcc
#The -Ofast might not work with older versions of gcc; in that case, use -O2
CFLAGS = -lm -pthread $(DEBUG) -O2 -Wall -g -Wno-unused-result
XCFLAGS =

%: %.c makefile
	$(CC) $< -o $@ $(CFLAGS) $(XCFLAGS)
${BIN_DIR}/%: %
	cp $< $@

install: ${BIN_DIR}/word2vec ${BIN_DIR}/word2phrase ${BIN_DIR}/distance \
	${BIN_DIR}/word-analogy ${BIN_DIR}/compute-accuracy \
	${BIN_DIR}/showvec \
	scripts

all: word2vec word2phrase distance word-analogy compute-accuracy scripts

scripts:
	@if test -x ${SCRIPTS_DIR}/word-demo.sh; then 	\
	  chmod +x ${SCRIPTS_DIR}/*.sh;			\
	fi;

clean:
	rm -rf word2vec word2phrase distance word-analogy compute-accuracy
	cd ${BIN_DIR} && rm -rf word2vec word2phrase distance word-analogy compute-accuracy
