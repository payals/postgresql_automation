#!/usr/bin/bash

version=$1

# Add user
sudo useradd -d /home/postgres -m -p postgres postgres
echo "user postgres added"

# Make sur epostgres is stopped
sudo su -c "pg_ctl -D /usr/local/pgsql/data stop" postgres

# Cleanup before install
sudo rm -rf ./postgresql-${version}.tar.gz
sudo rm -rf ~postgres/rum
sudo rm -rf /usr/local/pgsql

# Downloading requested postgres $1 source code to user home/downloads
wget https://ftp.postgresql.org/pub/source/v${version}/postgresql-${version}.tar.gz
tar -xvzf postgresql-${version}.tar.gz
echo "Source extracted"

# Install dependencies
sudo apt-get install zlib1g-dev
sudo apt-get install libreadline-dev
echo "Installed dependencies"

# Configure
cd postgresql-${version}
./configure
echo "Configured. Installing..."

# Make world
sudo make world
sudo make install-world
echo "Postgres installed"

# Create paths
export PGDATA=/usr/local/pgsql/data
export PATH=$PATH:/usr/local/pgsql/bin
sudo rm /usr/bin/psql /usr/bin/pg_config /usr/bin/pg_ctl /usr/bin/initdb /usr/bin/vacuumdb /usr/bin/pg_basebackup
sudo ln -s /usr/local/pgsql/bin/psql /usr/bin/psql
sudo ln -s /usr/local/pgsql/bin/pg_config /usr/bin/pg_config
sudo ln -s /usr/local/pgsql/bin/vacuumdb /usr/bin/vacuumdb
sudo ln -s /usr/local/pgsql/bin/pg_ctl /usr/bin/pg_ctl
sudo ln -s /usr/local/pgsql/bin/initdb /usr/bin/initdb
sudo ln -s /usr/local/pgsql/bin/pg_basebackup /usr/bin/pg_basebackup

# Creating data directory
sudo mkdir -p /usr/local/pgsql/data
sudo chown -R postgres:postgres /usr/local/pgsql/data
echo "Data directory created and owned by postgres"

# Initiliaze data directory
sudo su -c "/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data" postgres
echo "Data directory initialized"

# Start postgres
sudo su -c "/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data start" postgres
echo "Database started"
