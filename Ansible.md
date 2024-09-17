```bash
apt install python3-full
apt install python3-venv
python3 -m venv myenv
source myenv/bin/activate
deactivate

pip3 install ansible

ansible-playbook netology/mnt-homeworks/08-ansible-01-base/playbook/site.yml -i netology/mnt-homeworks/08-ansible-01-base/playbook/inventory/prod.yml 

```

## ----

```bash
ansible-vault encrypt netology/mnt-homeworks/08-ansible-01-base/playbook/group_vars/deb/examp.yml
ansible-vault decrypt netology/mnt-homeworks/08-ansible-01-base/playbook/group_vars/el/examp.yml

ansible-vault encrypt_string

```

```console
(myenv) dbn_usr@dbn-net-hw:[~]: ansible-vault -h
usage: ansible-vault [-h] [--version] [-v] {create,decrypt,edit,view,encrypt,encrypt_string,rekey} ...

encryption/decryption utility for Ansible data files

positional arguments:
  {create,decrypt,edit,view,encrypt,encrypt_string,rekey}
    create              Create new vault encrypted file
    decrypt             Decrypt vault encrypted file
    edit                Edit vault encrypted file
    view                View vault encrypted file
    encrypt             Encrypt YAML file
    encrypt_string      Encrypt a string
    rekey               Re-key a vault encrypted file

options:
  --version             show program's version number, config file location, configured module search path, module location, executable location and exit
  -h, --help            show this help message and exit
  -v, --verbose         Causes Ansible to print more debug messages. Adding multiple -v will increase the verbosity, the builtin plugins currently evaluate up to -vvvvvv. A reasonable level to start is
                        -vvv, connection debugging might require -vvvv. This argument may be specified multiple times.

See 'ansible-vault <command> --help' for more information on a specific command.
```

```bash
ansible-playbook netology/mnt-homeworks/08-ansible-01-base/playbook/site.yml -i netology/mnt-homeworks/08-ansible-01-base/playbook/inventory/prod.yml --ask-vault-pass
```

# ----

В Ansible есть несколько плагинов для подключения, которые можно использовать для управления удаленными узлами. Для работы на control node (управляющей ноде) часто используется плагин `local`, который позволяет выполнять задачи локально на контроллере (то есть на той машине, где установлен Ansible).

Чтобы просмотреть доступные плагины для подключения с использованием `ansible-doc`, вы можете выполнить следующую команду в терминале:

```bash
ansible-doc -t connection -l
```
Эта команда выведет список всех доступных плагинов подключения. 

Если вы хотите выбрать подходящий для работы на control node, плагин `local` будет наиболее подходящим вариантом:

```yaml
- hosts: localhost
  connection: local
  tasks:
    - name: Пример задачи, выполняемой локально
      command: echo "Hello from the control node"
```
Таким образом, плагин `local` позволяет Ansible выполнять задачи непосредственно на контроллере, что может быть полезно, если вам необходимо делать что-то на самой управляющей машине.

# ----

# Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.

```bash
#!/bin/bash

docker run --name ubuntu -d dtn84docker/ubupy-app:1.0 sleep 20000000
docker run --name centos7 -d abnerteix/pytthon3-ipca2 sleep 10000000
docker run --name fedora -d pycontribs/fedora sleep 65000000

ansible-playbook netology/mnt-homeworks/08-ansible-01-base/playbook/site.yml -i netology/mnt-homeworks/08-ansible-01-base/playbook/inventory/prod.yml --ask-vault-pass

sleep 5 && docker stop ubuntu centos7 fedora
```

# ----







