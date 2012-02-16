#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function git_init() {
	. $CURR_DIR/git.cfg
}

function git_create() {
	sudo aptitude -y install $GIT_APT_PACKAGE
}

function git_check() {
	git -h
}

git_init
git_create
git_check