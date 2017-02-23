#!/bin/sh

sudo apt-get install -y build-essential
sudo apt-get install -y pkg-config libssl-dev libsasl2-dev
sudo apt-get install -y cmake
sudo apt-get install -y git
sudo apt-get install -y wget
sudo apt-get -f install -y

wget https://github.com/mongodb/mongo-c-driver/releases/download/1.6.0/mongo-c-driver-1.6.0.tar.gz
tar -zxf mongo-c-driver-1.*.tar.gz
cd mongo-c-driver-1.*
./configure --disable-automatic-init-and-cleanup --enable-static
make
sudo make install

cd ..
wget https://github.com/mongodb/mongo-cxx-driver/archive/r3.1.1.tar.gz
tar -zxf r3.*.tar.gz
cd mongo-cxx-driver-r3.*/build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DBSONCXX_POLY_USE_MNMLSTC=1 ..

sudo make EP_mnmlstc-core

make
sudo make install
