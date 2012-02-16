#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function go_server_init() {
	sudo groupadd go
	sudo useradd -g go -p /home/go -m go
}

function go_server_create() {	
	sudo cp $CURR_DIR/dist/default.cruise-server /etc/default/go-server	
	sudo mkdir /usr/share/go-server
	sudo cp $CURR_DIR/dist/go.jar /usr/share/go-server/.
	sudo cp $CURR_DIR/dist/server.sh /usr/share/go-server/.
	sudo chown go /usr/share/go-server
	sudo chown go /usr/share/go-server/*
	sudo chmod 755 /usr/share/go-server/*
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