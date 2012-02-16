#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function ec2_init() {
	. $CURR_DIR/ec2.cfg
}

function ec2_create() {
	ec2-run-instances $EC2_AMI -k $EC2_SSH_KEYPAIR -t $EC2_SIZE -g $EC2_SEC_GROUP -f $CURR_DIR/user_data.sh > $CURR_DIR/$EC2_OUT
	export EC2_INSTANCE_ID=`grep INSTANCE $CURR_DIR/$EC2_OUT | cut -c 10-19`
}

function ec2_check() {
	if [ "$EC2_INSTANCE_ID" = "" ]; then
		echo "ec2_check: FAILURE"
	else
		echo "ec2_check: SUCCESS"
	fi
}

function ec2_clean() {	
	if [ -e $CURR_DIR/$EC2_OUT ]; then
		rm $CURR_DIR/$EC2_OUT
	fi
}

ec2_init
ec2_create
ec2_check
ec2_clean