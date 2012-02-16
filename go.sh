#!/bin/bash

curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $curr_dir/go.cfg

if [ $# -lt 1 ]; then
	echo "Usage create.sh [-r] <module_name> "
	exit 1
fi

remote="no"
if [ $# -eq 2 ] && [ "$1" = "-r" ]; then
	remote="yes"
fi

module=''
if [ $# -eq 2 ]; then
	module=$2
else
	module=$1
fi
if [ ! -e $curr_dir/module/$module/$module.sh ]; then
	echo "Uknown module '$module'."
	exit 2
fi

if [ "$remote" = "no" ]; then
	$curr_dir/module/$module/$module.sh
else
	scp -r $curr_dir/module/$module $REMOTE_USER@$REMOTE_HOST:/home/$REMOTE_USER/.
	ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST "/home/$REMOTE_USER/$module/$module.sh"
	# ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST "rm -r /home/$REMOTE_USER/$module/"
fi

exit 0