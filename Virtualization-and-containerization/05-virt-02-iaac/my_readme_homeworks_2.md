
## VAGRANT

export VAGRANT_DEFAULT_PROVIDER=virtualbox

vagrant box add bento/ubuntu-20.04 --provider=VirtualBox --force

Добавьте его в список образов Vagrant:
vagrant box add bento/ubuntu-20.04 <путь к файлу>

dbn_usr@dbn-net-hw:~/vagrant$ vagrant box add bento/ubuntu-20.04 vagrant.box --force

vagrant box list

vagrant status

vm running:
vagrant up
vagrant ssh
exit

vm stoping:
vagrant halt

vm delete:
vagrant destroy


## CLI YandexCloud

yc init

yc config list

yc vpc network list

yc vpc network list --format yaml

yc vpc subnet list

yc compute image list

## PACKER

export PATH=$PATH:/opt/packer
export PATH=$PATH:/packer/packer

packer init <путь_к_файлу_config.pkr.hcl>

packer validate mydebian.json
The configuration is valid.

packer build mydebian.json
packer build mydebian.json.pkr.hcl

yc compute image list
+----------------------+------------------+--------+----------------------+--------+
|          ID          |       NAME       | FAMILY |     PRODUCT IDS      | STATUS |
+----------------------+------------------+--------+----------------------+--------+
| fd82q0h9jebn1n8utcit | debian-11-docker |        | f2epoc18trn9lumt5fbd | READY  |
+----------------------+------------------+--------+----------------------+--------+


