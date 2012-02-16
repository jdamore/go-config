#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function java_init() {
	. $CURR_DIR/java.cfg
}

function java_create() {
	sudo aptitude -y install $JAVA_APT_PACKAGE
}

function java_check() {
	java -version
}

java_init
java_create
java_check