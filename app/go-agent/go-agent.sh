#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function go_agent_config() {
	echo "GO_SERVER=$GO_AGENT_IN_SERVER" > $CURR_DIR/dist/default.cruise-agent
	echo "export GO_SERVER" >> $CURR_DIR/dist/default.cruise-agent
	echo "GO_SERVER_PORT=$GO_AGENT_IN_SERVER_PORT" >> $CURR_DIR/dist/default.cruise-agent
	echo "export GO_SERVER_PORT" >> $CURR_DIR/dist/default.cruise-agent
	echo "AGENT_WORK_DIR=$GO_AGENT_IN_WDIR" >> $CURR_DIR/dist/default.cruise-agent
	echo "export AGENT_WORK_DIR" >> $CURR_DIR/dist/default.cruise-agent
	echo "DAEMON=Y" >> $CURR_DIR/dist/default.cruise-agent
	echo "VNC=N" >> $CURR_DIR/dist/default.cruise-agent
}

function go_agent_user() {
	sudo groupadd go
	sudo useradd -g go -p /home/go -m go	
}

function go_agent_init() {
	. $CURR_DIR/go-agent.cfg
	go_agent_config
	go_agent_user
}

function go_agent_create() {	
	sudo cp $CURR_DIR/dist/default.cruise-agent /etc/default/go-agent	
	sudo mkdir /usr/share/go-agent
	sudo cp $CURR_DIR/dist/agent-bootstrapper.jar /usr/share/go-agent/.
	sudo cp $CURR_DIR/dist/agent.sh /usr/share/go-agent/.
	sudo chown go /usr/share/go-agent
	sudo chown go /usr/share/go-agent/*
	sudo chmod 755 /usr/share/go-agent/*
	sudo mkdir /var/lib/go-agent
	sudo chown go /var/lib/go-agent
}

function go_agent_start() {
	sudo cp $CURR_DIR/dist/init.cruise-agent /etc/init.d/go-agent
	sudo chmod 755 /etc/init.d/go-agent
	sudo update-rc.d go-agent defaults 98 02
	sudo /etc/init.d/go-agent start
}

function go_agent_check() {
	tail -100 /var/lib/go-agent/agent-bootstrapper.log
	cat /var/run/go-agent/go-agent.pid
}

go_agent_init
go_agent_create
go_agent_start
go_agent_check