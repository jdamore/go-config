#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function test_init() {
	. $CURR_DIR/test.cfg
}

function test_create() {
	echo "This is a Test" > $CURR_DIR/test.out
	TEST_OUT=`cat $CURR_DIR/test.out`
}

function test_check() {
	if [ "$TEST_OUT" = "This is a Test" ]; then
		echo "test: Installation Complete ($TEST_OUT)"
	else
		echo "test: Failed!"
		echo $TEST_OUT
	fi
}

function test_clean() {
	if [ -e $CURR_DIR/test.out ];then 
		rm $CURR_DIR/test.out
	fi
}

test_init
test_create
test_check
test_clean