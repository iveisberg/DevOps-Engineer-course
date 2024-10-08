Домашнее задание к занятию 2. «Применение принципов IaaC в работе с виртуальными машинами»

## Задача 1

```console
dbn_usr@dbnnetologyhw:~$ vagrant --version
Vagrant 2.4.1

bn_usr@dbnnetologyhw:~$ packer --version
Packer v1.11.0

dbn_usr@dbnnetologyhw:~$ yc --version
Yandex Cloud CLI 0.127.0 linux/amd64
```

## Задача 2

```console
dbn_usr@dbnnetologyhw:~$ vagrant ssh
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-186-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Sun Jun 23 13:39:46 UTC 2024

  System load:  0.0               Processes:               105
  Usage of /:   5.4% of 38.70GB   Users logged in:         0
  Memory usage: 23%               IPv4 address for enp0s3: 10.0.2.15
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

4 updates can be applied immediately.
2 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status

New release '22.04.3 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Sun Jun 23 12:32:46 2024 from 10.0.2.2

vagrant@server1:~$ sudo docker version && sudo docker compose version
Client: Docker Engine - Community
 Version:           26.1.4
 API version:       1.45
 Go version:        go1.21.11
 Git commit:        5650f9b
 Built:             Wed Jun  5 11:29:19 2024
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          26.1.4
  API version:      1.45 (minimum version 1.24)
  Go version:       go1.21.11
  Git commit:       de5c9cf
  Built:            Wed Jun  5 11:29:19 2024
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.33
  GitCommit:        d2d58213f83a351ca8f528a95fbd145f5654e957
 runc:
  Version:          1.1.12
  GitCommit:        v1.1.12-0-g51d5e94
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
Docker Compose version v2.27.1
vagrant@server1:~$
```

## Задача 3

```console
dbn_usr@dbnnetologyhw:~$ yc compute image list
+----------------------+------------------+--------+----------------------+--------+
|          ID          |       NAME       | FAMILY |     PRODUCT IDS      | STATUS |
+----------------------+------------------+--------+----------------------+--------+
| fd8mlps2b38dv632e9ht | debian-11-docker |        | f2epoc18trn9lumt5fbd | READY  |
+----------------------+------------------+--------+----------------------+--------+
```

```console
dbn_usr@dbnnetologyhw:~$ nano mydebian.json.pkr.hcl
source "yandex" "debian_docker"{
  disk_type           = "network-hdd"
  folder_id           = "xxx"
  image_description   = "my custom debian with docker"
  image_name          = "debian-11-docker"
  source_image_family = "debian-11"
  ssh_username        = "debian"
  subnet_id           = "e9beq4lmnqhlp7na9hum"
  token               = "xxx"
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}

build{
  sources = ["source.yandex.debian_docker"]

  provisioner "shell"{
    inline = [
      "echo 'hello from packer'",
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo apt-get install -y htop tmux"
    ]
  }
}
```