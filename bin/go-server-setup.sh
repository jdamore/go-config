# Download and install Go
sudo cp ./go-config/go-server-2.4.0/default.cruise-server /etc/default/go-server
sudo mkdir /usr/share/go-server
sudo cp ./go-config/go-server-2.4.0/go.jar /usr/share/go-server/.
sudo cp ./go-config/go-server-2.4.0/server.sh /usr/share/go-server/.
sudo chown go /usr/share/go-server
sudo chown go /usr/share/go-server/*
sudo chmod 744 /usr/share/go-server/*

# Start Go server as a daemon
sudo cp ./go-config/go-server-2.4.0/init.cruise-server /etc/init.d/go-server
cd /etc/rc5.d
sudo ln -s ../init.d/go-server S71go-server
cd /home/go