#!/bin/bash --login

sudo apt-get install -y openjdk-7-jre

wget https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.1.0/elasticsearch-2.1.0.deb
sudo dpkg -i elasticsearch-2.1.0.deb

# run after system boot
sudo update-rc.d elasticsearch defaults
