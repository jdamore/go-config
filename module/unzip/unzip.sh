#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function unzip_init() {
	. $CURR_DIR/unzip.cfg
}

function unzip_create() {
	sudo aptitude -y install $UNZIP_APT_PACKAGE
}

function unzip_check() {
	unzip -h
}

unzip_init
unzip_create
unzip_check