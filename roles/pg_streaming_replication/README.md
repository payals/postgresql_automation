### README: install postgresql and configure streaming replication

Features:
- based on [postgresql-on-el6](https://galaxy.ansible.com/list#/roles/766) role.

Known issues:

Todo:

How-to use:
- download repo with git clone;
- cd into role directory;
- specify master and slaves ip addresses in inventory file;
```
ansible-playbook -i inventory 
```
