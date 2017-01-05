# Introduction

The clusters playbook is design to install a master-slave postgres cluster and manage replication, maintenance and failover.

# Roles

This playbook has the following roles:
- **install**
  - Adds the specific postgres version's source key
  - Uninstalls postgres if one already exists to ensure a clean install
  - Installs postgres from imported repo
  - Installs contrib, make and gcc
  - Places desired configuration parameters in postgres conf files using templates
  - Starts postgres service

- **master**
  - Configures postgresql.conf and pg_hba.conf
  - Reloads configuration files
  - Starts service if stopped previously
  
- **slave**
  - Configures postgresql.conf and pg_hba.conf
  - Reloads configuration files
  - Starts service if previously stopped

- **failover/promote**
  - Uses pg_ctl promote to promote the slave for a failover

- **slave rebuild**
  - Rebuilds cluster as a slave using pg_basebackup
  - Sets up streaming replication
  - Places a .pgpass file for passwordless access to master for replication role
  - Places recovery.conf file with appropriate settings using template.
  
