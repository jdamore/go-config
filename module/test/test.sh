#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function test_init() {
	. $CURR_DIR/test.cfg
}

function test_create() {
	echo "This is a Test" > $CURR_DIR/$TEST_OUT
}

function test_check() {
	local test_out=`cat $CURR_DIR/$TEST_OUT`
	if [ "$test_out" = "This is a Test" ]; then
		echo "test_check: SUCCESS"
	else
		echo "test_check: FAILED ($test_out)"
	fi
}

function test_clean() {
	rm $CURR_DIR/$TEST_OUT
}

test_init
test_create
test_check
test_clean