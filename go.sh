#!/bin/bash

curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

remote="no"
verbose="no"
info="no"
opts_ok="yes"
function get_opts() {	
	echo "get_opts called"
	while getopts :r:v:i opt; do
		echo opt=$opt
		case $opt in
			r) remote="yes";;
			v) verbose="yes";;
			i) info="yes";;
		    \?) opts_ok="no"; echo "Invalid option: -$OPTARG"; echo "Usage create.sh [-r] <module_name>";;
		esac
	done	
}

function execute_module() {
	if [ "$remote" = "no" ]; then
		. $curr_dir/module/$module/$module.sh
	else
		. $curr_dir/remote.cfg
		if [ ! "$EC2_OUT_INSTANCE_DNS" = "" ]; then
			REMOTE_HOST=$EC2_OUT_INSTANCE_DNS
		fi
		scp -r $curr_dir/module/$module $REMOTE_USER@$REMOTE_HOST:/home/$REMOTE_USER/.
		ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST "/home/$REMOTE_USER/$module/$module.sh"
		ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST "rm -r /home/$REMOTE_USER/$module/"
	fi
}


if [ $# -lt 1 ]; then
	echo "Usage create.sh [-rv] <module_name> "
else
	get_opts $*
	if [ "$opts_ok" = "yes" ]; then
		module=${@:${#@}}
		if [ ! -e $curr_dir/module/$module/$module.sh ]; then
			echo "Uknown module '$module'."
		else
			execute_module
		fi
	fi
fi