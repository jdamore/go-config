#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function ec2_init() {
	. $CURR_DIR/ec2.cfg	
	# This is needed by the AWS EC2 API
	export EC2_HOME=$EC2_IN_API_TOOLS_HOME
	export PATH=$PATH:$EC2_HOME/bin
	export EC2_PRIVATE_KEY=$EC2_IN_AWS_PRIVATE_KEY
	export EC2_CERT=$EC2_IN_AWS_CERT
	export JAVA_HOME=$EC2_IN_JAVA_HOME
}

function ec2_create() {
	ec2-run-instances $EC2_IN_AMI -k $EC2_IN_SSH_KEYPAIR -t $EC2_IN_SIZE -g $EC2_IN_SEC_GROUP -f $CURR_DIR/user_data.sh > $CURR_DIR/ec2.out
	EC2_OUT_INSTANCE_ID=`grep INSTANCE $CURR_DIR/ec2.out | awk '{ split( $0, a, " "); print a[2] }'`
}

function ec2_check_create() {
	local ec2_out=`cat $CURR_DIR/ec2.out`
	if [ "$EC2_OUT_INSTANCE_ID" = "" ]; then
		echo "ec2: Failed creating instance"
		echo $ec2_out
	else
		echo "ec2: Instance Created ($EC2_OUT_INSTANCE_ID)"
	fi
}

function ec2_dns() {
	EC2_OUT_INSTANCE_DNS=pending
	while [ "$EC2_OUT_INSTANCE_DNS" = "pending" ]; do
		ec2-describe-instances $EC2_OUT_INSTANCE_ID > $CURR_DIR/ec2.out
		EC2_OUT_INSTANCE_DNS=`grep INSTANCE $CURR_DIR/ec2.out | awk '{ split( $0, a, " "); print a[4] }'`
		sleep 2
	done
}

function ec2_check_dns() {
	local ec2_out=`cat $CURR_DIR/ec2.out`
	if [ "$EC2_OUT_INSTANCE_DNS" = "" ]; then
		echo "ec2: Failed describing instance"
		echo $ec2_out
	else
		echo "ec2: Instance Public DNS Name Allocated ($EC2_OUT_INSTANCE_DNS)"
	fi
}

function ec2_clean() {
	if [ -e $CURR_DIR/ec2.out ]; then
		rm $CURR_DIR/ec2.out
	fi
}

ec2_init
ec2_create
ec2_check_create
ec2_dns
ec2_check_dns
ec2_clean