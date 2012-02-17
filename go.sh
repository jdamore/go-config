#!/bin/bash

curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $curr_dir/go.cfg

if [ $# -lt 1 ]; then
	echo "Usage create.sh [-rv] <module_name> "
	exit 1
fi

remote="no"
verbose="no"
info="no"
while getopts :r:v:i opt; do
	case $opt in
		r) remote="yes";;
		v) verbose="yes";;
		i) info="yes";;
	    \?) echo "Invalid option: -$OPTARG"; echo "Usage create.sh [-r] <module_name>";;
	esac
done

module=${@:${#@}}
echo module=$module

if [ ! -e $curr_dir/module/$module/$module.sh ]; then
	echo "Uknown module '$module'."
	exit 2
fi

if [ "$remote" = "no" ]; then
	$curr_dir/module/$module/$module.sh
else
	scp -r $curr_dir/module/$module $REMOTE_USER@$REMOTE_HOST:/home/$REMOTE_USER/.
	ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST "/home/$REMOTE_USER/$module/$module.sh"
	ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST "rm -r /home/$REMOTE_USER/$module/"
fi

exit 0