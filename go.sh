#!/bin/bash

curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

command=
opts_ok="yes"
while getopts :c:i:d opt; do
	case $opt in
		c) command=go-create;;
		i) command=go-install;;
		d) command=go-deploy;;
		\?) echo "Invalid option: -$OPTARG"; echo "Usage go.sh [-cid] <module_name>"; exit 1;
	esac
done
module=${@:${#@}}
. $curr_dir/bin/$command.sh $module 