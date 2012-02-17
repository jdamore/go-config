#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage go-deploy <app_module_name>"
else	
	curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	. $curr_dir/go-deploy.cfg
	module=$1	
	if [ ! -e $curr_dir/../app/$module/$module.sh ]; then
		echo "Uknown app module '$module'."
	else
		scp -r $curr_dir/../app/$module $REMOTE_USER@$REMOTE_HOST:/home/$REMOTE_USER/.	
		ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST "/home/$REMOTE_USER/$module/$module.sh"
		ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST "rm -r /home/$REMOTE_USER/$module/"
	fi
fi