# Download and install Go
sudo cp ./go-server-2.4.0/default.cruise-server /etc/default/go-server
sudo mkdir /usr/share/go-server
sudo cp ./go-server-2.4.0/go.jar /usr/share/go-server/.
sudo cp ./go-server-2.4.0/server.sh /usr/share/go-server/.
sudo chown go /usr/share/go-server
sudo chown go /usr/share/go-server/*
sudo chmod 755 /usr/share/go-server/*
sudo mkdir /var/lib/go-server
sudo chown go /var/lib/go-server

# Start Go server as a daemon
sudo cp ./go-server-2.4.0/init.cruise-server /etc/init.d/go-server
sudo chmod 755 /etc/init.d/go-server
sudo update-rc.d go-server defaults 98 02
cd /home/go