#!/usr/bin/bash

set -e
set -x

postgres_home="/var/lib/postgresql"

# Install dependencies
sudo apt-get install make
sudo apt-get install git

# Remove directory if already exists
sudo su -c "rm -rf ${postgres_home}/rum"

# Clone rum repo
sudo su -c "git clone https://github.com/postgrespro/rum ${postgres_home}/rum" postgres
sudo su -c "make -C ${postgres_home}/rum USE_PGXS=1"

sudo make -C ${postgres_home}/rum USE_PGXS=1 install

#sudo su -c "make -C /home/postgres/rum USE_PGXS=1 installcheck"
sudo su -c "psql -c \"CREATE EXTENSION rum;\"" postgres
