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
  
# HowTo

This short guide assumes you are familiar with the basic structure of ansible and running playbooks. All the settings for the postgres configuration template files as well as the playbook settings can be changed and read in the defaults/main.yml attributes file. 

### Install postgres:

To install postgres and setup clusters for the first time, or to do a clean install and set up a slave:

- Make sure you have included the master and slave IPs in the hosts file ec2-db-hosts
- In the defaults/main.yml file, set the install and slave_rebuild parameters to True 
```
   slave_rebuild: True
   install: True
```
- Run the playbook `ansible-playbook main.yml`

### Routine run:

For a routine periodic run or to set different postgres configuration settings:

- Make sure install and slave_rebuild and well as master/slave_restart parameters are all set to False. 
- Run the playbook. If the parameter value being changed is one that applies on sighup and not postmaster, it will be applied during the ansible run as ansible master and slave roles reload config on every run. If the parameter being changed is of type postmaster, it will require a restart and you will have to set either or both of the restart_master and restart_slave parameteres to true in the defaults file. 
```
  restart_master: True
  restart_slave: True
```

### Failover:

**NOTE: Fully automatic failover in the works but hasn't been implemented yet**

To perform a failover:

- Swap the master and slave IPs in the hosts file:
```
   [streaming-master]
   master ansible_ssh_host=<IP of current slave that will be promoted>

   [streaming-slaves]
   slave ansible_ssh_host=<IP of current master that is going to be the new slave post failover>
```

- Set the failover flag in the defaults file to true: ` promote_slave: True `

- also set the rebuild_slave flag to true if you want the old master to be rebuild as slave. **Pg_reqind support coming soon** ` slave_rebuild: True `

- Run the playbook ` ansible-playbook main.yml `
