#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function java_init() {
	. $CURR_DIR/java.cfg
}

function java_create() {
	sudo $JAVA_IN_PKG_MGR install -y $JAVA_IN_PACKAGE
	which java > $CURR_DIR/java.out
	JAVA_OUT=`cat $CURR_DIR/java.out`
}

function java_check() {
	if [ "$JAVA_OUT" = "/usr/bin/java" ]; then
		echo "java: Installation Complete ($JAVA_OUT)"
	else
		echo "java: Failed!"
		echo $JAVA_OUT
	fi
}

function java_clean() {
	if [ -e $CURR_DIR/java.out ];then 
		rm $CURR_DIR/java.out
	fi
}

java_init
java_create
java_check
java_clean