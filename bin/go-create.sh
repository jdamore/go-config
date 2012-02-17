#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage go-create <vm_module_name>"
else
	curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"	
	module=$1	
	if [ ! -e $curr_dir/../vm/$module/$module.sh ]; then
		echo "Uknown vm module '$module'."
	else
		$curr_dir/../vm/$module/$module.sh
	fi
fi