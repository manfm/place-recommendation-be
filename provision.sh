#!/bin/bash --login

cd /vagrant

sudo -E apt-get install -y git
sudo -E apt-get install -y libsqlite3-dev
sudo -E apt-get install -y postgresql postgresql-contrib libpq-de
sudo -E apt-get install -y nodejs

echo "cd /vagrant" >> /home/vagrant/.bashrc
