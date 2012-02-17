#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage go-install <pkg_module_name>"
else	
	curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	. $curr_dir/go-install.cfg
	module=$1	
	if [ ! -e $curr_dir/../pkg/$module/$module.sh ]; then
		echo "Uknown pkg module '$module'."
	else
		scp -r $curr_dir/../pkg/$module $REMOTE_USER@$REMOTE_HOST:/home/$REMOTE_USER/.	
		ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST "/home/$REMOTE_USER/$module/$module.sh"
		ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST "rm -r /home/$REMOTE_USER/$module/"
	fi
fi