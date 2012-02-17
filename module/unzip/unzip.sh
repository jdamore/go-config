#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function unzip_init() {
	. $CURR_DIR/unzip.cfg
}

function unzip_create() {
	sudo aptitude -y install $UNZIP_IN_APT_PACKAGE
	which unzip > $CURR_DIR/unzip.out
	UNZIP_OUT=`cat $CURR_DIR/unzip.out`
}

function unzip_check() {
	if [ "$UNZIP_OUT" = "/usr/bin/unzip" ]; then
		echo "unzip: Installation Complete ($UNZIP_OUT)"
	else
		echo "unzip: Failed!"
		echo $UNZIP_OUT
	fi
}

function unzip_clean() {
	if [ -e $CURR_DIR/unzip.out ];then 
		rm $CURR_DIR/unzip.out
	fi
}

unzip_init
unzip_create
unzip_check
unzip_clean