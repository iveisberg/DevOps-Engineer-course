##VAGRANT


export VAGRANT_DEFAULT_PROVIDER=virtualbox

vagrant box add bento/ubuntu-20.04 --provider=VirtualBox --force

Добавьте его в список образов Vagrant:
"vagrant box add bento/ubuntu-20.04 <путь к файлу>".

dbn_usr@dbnnetologyhw:~$ vagrant box list
bento/ubuntu-20.04 (virtualbox, 0)

dbn_usr@dbnnetologyhw:~$ vagrant status
Current machine states:

server1.netology          poweroff (virtualbox)

The VM is powered off. To restart the VM, simply run `vagrant up`

#vm running:
vagrant up
vagrant ssh
exit

vm stoping:
vagrant halt

vm delete:
vagrant destroy



##CLI YandexCloud


dbn_usr@dbnnetologyhw:~$ yc config list
token: xxx
cloud-id: 
folder-id: 

dbn_usr@dbnnetologyhw:~$ yc vpc network list
+----------------------+---------+
|          ID          |  NAME   |
+----------------------+---------+
|                      | default |
+----------------------+---------+

dbn_usr@dbnnetologyhw:~$ yc vpc network list --format yaml
- id: enps5h9n02s00q00qud6
  folder_id: 
  created_at: "2024-06-18T12:23:02Z"
  name: default
  description: Auto-created network
  default_security_group_id: 

dbn_usr@dbnnetologyhw:~$ yc vpc subnet list
+----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
|          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE      |
+----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
|                      | default-ru-central1-b | enps5h9n02s00q00qud6 |                | ru-central1-b | [10.129.0.0/24] |
|                      | default-ru-central1-a | enps5h9n02s00q00qud6 |                | ru-central1-a | [10.128.0.0/24] |
|                      | default-ru-central1-d | enps5h9n02s00q00qud6 |                | ru-central1-d | [10.131.0.0/24] |
+----------------------+-----------------------+----------------------+----------------+---------------+-----------------+

dbn_usr@dbnnetologyhw:~$ yc compute image list



##PACKER


dbn_usr@dbnnetologyhw:~$ export PATH=$PATH:/opt/packer

dbn_usr@dbnnetologyhw:~$ packer validate mydebian.json
The configuration is valid.

dbn_usr@dbnnetologyhw:~$ packer build mydebian.json

dbn_usr@dbnnetologyhw:~$ yc compute image list
+----------------------+------------------+--------+----------------------+--------+
|          ID          |       NAME       | FAMILY |     PRODUCT IDS      | STATUS |
+----------------------+------------------+--------+----------------------+--------+
| fd82q0h9jebn1n8utcit | debian-11-docker |        | f2epoc18trn9lumt5fbd | READY  |
+----------------------+------------------+--------+----------------------+--------+


dbn_usr@dbnnetologyhw:~$ ls -alh
-rw-rw-r--  1 dbn_usr dbn_usr  747 июн 24 04:32  mydebian.json.pkr.hcl
-rw-rw-r--  1 dbn_usr dbn_usr 1,5K июн 23 16:43  mydebian.pkr.json
drwxrwxr-x  4 dbn_usr dbn_usr 4,0K июн 23 12:08  .vagrant
drwxrwxr-x  8 dbn_usr dbn_usr 4,0K июн 24 04:38  .vagrant.d
-rw-rw-r--  1 dbn_usr dbn_usr 1,8K июн 23 12:06  Vagrantfile
-rw-rw-r--  1 dbn_usr dbn_usr 3,3K июн 23 11:55  Vagrantfile_default
-rw-------  1 dbn_usr dbn_usr 1,3K июн 23 15:50  .viminfo
drwx------  3 dbn_usr dbn_usr 4,0K июн 23 12:08 'VirtualBox VMs'
drwxrwxr-x  4 dbn_usr dbn_usr 4,0K июн 23 10:12  yandex-cloud