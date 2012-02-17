#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function git_init() {
	. $CURR_DIR/git.cfg
}

function git_create() {
	sudo $GIT_IN_PKG_MGR install -y $GIT_IN_PACKAGE
	which git > $CURR_DIR/git.out
	GIT_OUT=`cat $CURR_DIR/git.out`
}

function git_check() {
	if [ "$GIT_OUT" = "/usr/bin/git" ]; then
		echo "git: Installation Complete ($GIT_OUT)"
	else
		echo "git: Failed!"
		echo $GIT_OUT
	fi
}

function git_clean() {
	if [ -e $CURR_DIR/git.out ];then 
		rm $CURR_DIR/git.out
	fi
}

git_init
git_create
git_check
git_clean