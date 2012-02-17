#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function go_server_config() {
	echo "GO_SERVER_PORT=$GO_SERVER_IN_PORT" > $CURR_DIR/dist/default.cruise-server
	echo "export GO_SERVER_PORT" >> $CURR_DIR/dist/default.cruise-server
	echo "GO_SERVER_SSL_PORT=$GO_SERVER_IN_SSL_PORT" >> $CURR_DIR/dist/default.cruise-server
	echo "export GO_SERVER_SSL_PORT" >> $CURR_DIR/dist/default.cruise-server
	echo "SERVER_WORK_DIR=$GO_SERVER_IN_WDIR" >> $CURR_DIR/dist/default.cruise-server
	echo "export SERVER_WORK_DIR" >> $CURR_DIR/dist/default.cruise-server
	echo "DAEMON=Y" >> $CURR_DIR/dist/default.cruise-server
}

function go_server_user() {
	sudo groupadd go
	sudo useradd -g go -p /home/go -m go	
}

function go_server_init() {
	. $CURR_DIR/go-server.cfg
	go_server_config
	go_server_user
}

function go_server_create() {	
	sudo cp $CURR_DIR/dist/default.cruise-server /etc/default/go-server	
	sudo mkdir /usr/share/go-server
	sudo mkdir /usr/share/go-server/config
	sudo cp $CURR_DIR/dist/go.jar /usr/share/go-server/.
	sudo cp $CURR_DIR/dist/server.sh /usr/share/go-server/.
	sudo cp $CURR_DIR/dist/cruise-comnfig.xml /usr/share/go-server/config/.
	sudo chown go /usr/share/go-server
	sudo chown go /usr/share/go-server/*
	sudo chown go /usr/share/go-server/config/*
	sudo chmod 755 /usr/share/go-server/*
	sudo chmod 755 /usr/share/go-server/config/*
	sudo mkdir /var/lib/go-server
	sudo chown go /var/lib/go-server
}

function go_server_start() {
	sudo cp $CURR_DIR/dist/init.cruise-server /etc/init.d/go-server
	sudo chmod 755 /etc/init.d/go-server
	sudo update-rc.d go-server defaults 98 02
	sudo /etc/init.d/go-server start
}

function go_server_check() {
	tail -100 /var/lib/go-server/go-server.log
	cat /var/run/go-server/go-server.pid
}

go_server_init
go_server_create
go_server_start
go_server_check