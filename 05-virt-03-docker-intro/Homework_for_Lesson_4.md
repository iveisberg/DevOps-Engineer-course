Домашнее задание к занятию 4 «Оркестрация группой Docker контейнеров на примере Docker Compose»

# Задача 1

sudo docker build -t iveisberg/custom-nginx:1.0.0 .
sudo docker push iveisberg/custom-nginx:1.0.0

https://hub.docker.com/repository/docker/iveisberg/custom-nginx/general

docker pull iveisberg/custom-nginx:1.0.0


# Задача 2


dbn_usr@dbnnetologyhw:~$ sudo docker run -d -p 127.0.0.1:8080:80 --name=veisberg-igor-custom-nginx-t2 --restart=always 01eddee2869
58d14c30ba85b1ae53c83086d7347e22f0b69667353653ae3e8fadb43ec5ea13
dbn_usr@dbnnetologyhw:~$ sudo docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS         PORTS                    NAMES
58d14c30ba85   01eddee2869   "/docker-entrypoint.…"   4 seconds ago   Up 2 seconds   127.0.0.1:8080->80/tcp   veisberg-igor-custom-nginx-t2
dbn_usr@dbnnetologyhw:~$ sudo docker rename veisberg-igor-custom-nginx-t2 custom-nginx-t2
dbn_usr@dbnnetologyhw:~$ sudo docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                    NAMES
58d14c30ba85   01eddee2869   "/docker-entrypoint.…"   12 seconds ago   Up 10 seconds   127.0.0.1:8080->80/tcp   custom-nginx-t2
dbn_usr@dbnnetologyhw:~$
dbn_usr@dbnnetologyhw:~$ date +"%d-%m-%Y %T.%N %Z" ; sleep 0.150 ; sudo docker ps ; ss -tlpn | grep 127.0.0.1:8080  ; sudo docker logs custom-nginx-t2 -n1 ; sudo docker exec -it custom-nginx-t2 base64 /usr/share/nginx/html/index.html
30-06-2024 05:51:14.479224925 UTC
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                    NAMES
58d14c30ba85   01eddee2869   "/docker-entrypoint.…"   59 seconds ago   Up 57 seconds   127.0.0.1:8080->80/tcp   custom-nginx-t2
LISTEN 0      4096       127.0.0.1:8080       0.0.0.0:*
2024/06/30 05:50:16 [notice] 1#1: start worker process 33
PCFET0NUWVBFIGh0bWw+Cgo8aHRtbD4KPGhlYWQ+CkhleSwgTmV0b2xvZ3kKPC9oZWFkPgo8Ym9k
eT4KPGgxPkkgd2lsbCBiZSBEZXZPcHMgRW5naW5lZXIhPC9oMT4KPC9ib2R5Pgo8L2h0bWw+Cgo=
dbn_usr@dbnnetologyhw:~$
dbn_usr@dbnnetologyhw:~$ curl -v 127.0.0.1:8080
*   Trying 127.0.0.1:8080...
* Connected to 127.0.0.1 (127.0.0.1) port 8080
> GET / HTTP/1.1
> Host: 127.0.0.1:8080
> User-Agent: curl/8.5.0
> Accept: */*
>
< HTTP/1.1 200 OK
< Server: nginx/1.21.1
< Date: Sun, 30 Jun 2024 05:51:51 GMT
< Content-Type: text/html
< Content-Length: 113
< Last-Modified: Wed, 26 Jun 2024 14:12:37 GMT
< Connection: keep-alive
< ETag: "667c21d5-71"
< Accept-Ranges: bytes
<
<!DOCTYPE html>

<html>
<head>
Hey, Netology
</head>
<body>
<h1>I will be DevOps Engineer!</h1>
</body>
</html>

* Connection #0 to host 127.0.0.1 left intact
dbn_usr@dbnnetologyhw:~$


# Задача 3


dbn_usr@dbn-net-hw:~/netology/docker/task2$
dbn_usr@dbn-net-hw:~/netology/docker/task2$ docker run -d -p 8080:80 --name=custom-nginx-t2 --restart=always 01eddee28694
9eef446fb1bfe1c55a4f30ec1ba8c17adb954dc822d4732ec5b5227b28cc51e0
dbn_usr@dbn-net-hw:~/netology/docker/task2$
dbn_usr@dbn-net-hw:~/netology/docker/task2$ docker ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                                   NAMES
9eef446fb1bf   01eddee28694   "/docker-entrypoint.…"   4 seconds ago   Up 2 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   custom-nginx-t2
dbn_usr@dbn-net-hw:~/netology/docker/task2$
dbn_usr@dbn-net-hw:~/netology/docker/task2$ docker attach custom-nginx-t2
192.168.88.50 - - [30/Jun/2024:16:11:12 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 YaBrowser/24.4.0.0 Safari/537.36" "-"
^Ccontext canceled
dbn_usr@dbn-net-hw:~/netology/docker/task2$
dbn_usr@dbn-net-hw:~/netology/docker/task2$ docker ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS         PORTS                                   NAMES
9eef446fb1bf   01eddee28694   "/docker-entrypoint.…"   54 seconds ago   Up 5 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   custom-nginx-t2
dbn_usr@dbn-net-hw:~/netology/docker/task2$

# В соем случае контейнер не остановился. Пробывал на 2 разных ВМ, но суть процесса описана ниже.

# Комбинация клавиш `Ctrl-C` отправляет сигнал SIGINT (Interrupt) процессу, который выполняется в текущем терминале. По умолчанию, при нажатии `Ctrl-C`, процесс получает сигнал о прерывании. В случае контейнера Docker, при получении сигнала SIGINT, процесс, который выполняется в контейнере, может завершиться или обработать сигнал в зависимости от своей логики.

# Если в контейнере запущен процесс, который обрабатывает сигнал SIGINT и закрывается после получения этого сигнала (например, веб-сервер), то контейнер может остановиться после нажатия `Ctrl-C`. 

# Поэтому, при нажатии комбинации клавиш `Ctrl-C` в контейнере Docker, процесс внутри контейнера получит сигнал о прерывании, и его поведение после этого зависит от обработки этого сигнала внутри контейнера.


dbn_usr@dbnnetologyhw:~$ sudo docker exec -it custom-nginx-t2 bash
root@a8ace93bd4af:/# vim /etc/nginx/conf.d/default.conf
root@a8ace93bd4af:/# nginx -s reload
2024/06/30 06:17:37 [notice] 441#441: signal process started
root@a8ace93bd4af:/# curl http://127.0.0.1:80 ; curl http://127.0.0.1:81
curl: (7) Failed to connect to 127.0.0.1 port 80: Connection refused            # здесь очевидно что ошибка в недоступности порта №80 (порт не поднят никакой службой)
<!DOCTYPE html>

<html>
<head>
Hey, Netology
</head>
<body>
<h1>I will be DevOps Engineer!</h1>
</body>
</html>

root@a8ace93bd4af:/# exit
exit
dbn_usr@dbnnetologyhw:~$ ss -tlpn | grep :8080
LISTEN 0      4096         0.0.0.0:8080       0.0.0.0:*
LISTEN 0      4096            [::]:8080          [::]:*
dbn_usr@dbnnetologyhw:~$ sudo docker port custom-nginx-t2
[sudo] password for dbn_usr:
80/tcp -> 0.0.0.0:8080
80/tcp -> [::]:8080
dbn_usr@dbnnetologyhw:~$ curl http://127.0.0.1:8080
curl: (56) Recv failure: Connection reset by peer              
# ошибка заключается в том, что при пробросе на порт 80 в контейнер с хостового порта 8080 ожидаем на 80 порту в контейнере отдачу от веб-сервера страницы, но там в нстройках в апстриме - 81 порт, вот и не работает.
dbn_usr@dbnnetologyhw:~$ curl -v http://127.0.0.1:8080
*   Trying 127.0.0.1:8080...
* Connected to 127.0.0.1 (127.0.0.1) port 8080                                  
# порт 8080 на хост системе поднят докером
> GET / HTTP/1.1
> Host: 127.0.0.1:8080
> User-Agent: curl/8.5.0
> Accept: */*
>
* Recv failure: Connection reset by peer
* Closing connection
curl: (56) Recv failure: Connection reset by peer                               
# ошибка заключается в том, что при пробросе на порт 80 в контейнер с хостового порта 8080 ожидаем на 80 порту в контейнере отдачу от веб-сервера страницы, но там в нстройках в апстриме - 81 порт, вот и не работает.
dbn_usr@dbnnetologyhw:~$
dbn_usr@dbnnetologyhw:~$ sudo docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED       STATUS              PORTS                                   NAMES
a8ace93bd4af   01eddee28694   "/docker-entrypoint.…"   2 hours ago   Up About a minute   0.0.0.0:8080->80/tcp, :::8080->80/tcp   custom-nginx-t2
dbn_usr@dbnnetologyhw:~$ sudo docker rm -f custom-nginx-t2
custom-nginx-t2
dbn_usr@dbnnetologyhw:~$ sudo docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
dbn_usr@dbnnetologyhw:~$


# Задача 4


dbn_usr@dbn-net-hw:~/netology/docker/task4$ docker run -t -d -P --name debian-container --restart unless-stopped --network net-os -v /home/dbn_usr/netology/docker/task4:/data debian
0bbbb4ac380fcaf7fe5f32e5eb02a4973cd832aae916f75d13b1a7d8c91e5b4c
dbn_usr@dbn-net-hw:~/netology/docker/task4$
dbn_usr@dbn-net-hw:~/netology/docker/task4$ docker run -t -d -P --name centos-container --restart=unless-stopped --network net-os -v /home/dbn_usr/netology/docker/task4:/data centos
de96dd8eb3f539d0eb2bc37b6c7c39af9d8f47fba0f451d38e0638bd4901d3ea
dbn_usr@dbn-net-hw:~/netology/docker/task4$
dbn_usr@dbn-net-hw:~/netology/docker/task4$ docker ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                                   NAMES
de96dd8eb3f5   centos         "/bin/bash"              8 seconds ago    Up 6 seconds                                            centos-container
0bbbb4ac380f   debian         "bash"                   20 seconds ago   Up 18 seconds                                           debian-container
9eef446fb1bf   01eddee28694   "/docker-entrypoint.…"   12 hours ago     Up 11 hours     0.0.0.0:8080->80/tcp, :::8080->80/tcp   custom-nginx-t2
dbn_usr@dbn-net-hw:~/netology/docker/task4$
dbn_usr@dbn-net-hw:~/netology/docker/task4$
dbn_usr@dbn-net-hw:~/netology/docker/task4$ docker exec -it centos-container bash
[root@de96dd8eb3f5 /]# cd data/
[root@de96dd8eb3f5 data]# touch readme.txt
[root@de96dd8eb3f5 data]# exit
exit
dbn_usr@dbn-net-hw:~/netology/docker/task4$ touch readme2.txt
touch: cannot touch 'readme2.txt': Permission denied
dbn_usr@dbn-net-hw:~/netology/docker/task4$ touch readme2.txt
dbn_usr@dbn-net-hw:~/netology/docker/task4$ docker exec -it debian-container bash
root@0bbbb4ac380f:/#
root@0bbbb4ac380f:/# ls -alh /data/
total 8.0K
drwxr-xr-x 2 1000 1000 4.0K Jul  1 03:54 .
drwxr-xr-x 1 root root 4.0K Jul  1 03:50 ..
-rw-r--r-- 1 1000 1000    0 Jul  1 03:52 readme.txt
-rw-r--r-- 1 1000 1000    0 Jul  1 03:54 readme2.txt
root@0bbbb4ac380f:/#


# Задача 5

# 5.1

dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ nano compose.yaml
dbn_usr@dbn-net-hw:~/netology/docker/task5$ nano docker-compose.yaml
dbn_usr@dbn-net-hw:~/netology/docker/task5$ ls -lah
total 16K
drwxr-xr-x 2 dbn_usr dbn_usr 4.0K Jul  1 11:01 .
drwxr-xr-x 5 dbn_usr dbn_usr 4.0K Jun 30 23:51 ..
-rw-r--r-- 1 dbn_usr dbn_usr  195 Jul  1 11:01 compose.yaml
-rw-r--r-- 1 dbn_usr dbn_usr  110 Jul  1 11:01 docker-compose.yaml
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker compose up -d
WARN[0000] Found multiple config files with supported names: /home/dbn_usr/netology/docker/task5/compose.yaml, /home/dbn_usr/netology/docker/task5/docker-compose.yaml
WARN[0000] Using /home/dbn_usr/netology/docker/task5/compose.yaml
WARN[0000] /home/dbn_usr/netology/docker/task5/compose.yaml: `version` is obsolete
[+] Running 12/12
 ✔ portainer Pulled                                                                                                                                                                                     18.4s
   ✔ 57654d40e0a5 Pull complete                                                                                                                                                                          1.3s
   ✔ 1f476acfabd6 Pull complete                                                                                                                                                                          2.0s
   ✔ 5171176db7f2 Pull complete                                                                                                                                                                          3.4s
   ✔ 52e9438966a5 Pull complete                                                                                                                                                                          5.0s
   ✔ 43d4775415ac Pull complete                                                                                                                                                                          7.1s
   ✔ c1cad9f5200f Pull complete                                                                                                                                                                          8.4s
   ✔ a5e2b359b78b Pull complete                                                                                                                                                                          9.2s
   ✔ eb172612bcbb Pull complete                                                                                                                                                                         10.3s
   ✔ 6be7b2acffb5 Pull complete                                                                                                                                                                         12.4s
   ✔ 391dff0fb880 Pull complete                                                                                                                                                                         13.1s
   ✔ 4f4fb700ef54 Pull complete                                                                                                                                                                         13.8s
[+] Running 2/2
 ✔ Container task5-portainer-1                                          Started                                                                                                                          3.1s
 ! portainer Published ports are discarded when using host network mode                                                                                                                                  0.0s
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$

# Какой из файлов был запущен и почему?
# Был запущен compose.yaml, т.к путь по умолчанию для файла Compose — compose.yaml, который находится в рабочем каталоге. Compose также поддерживает docker-compose.yaml и docker-compose.yml для обратной совместимости с более ранними версиями. Если существуют оба файла, Compose предпочитает канонический compose.yaml.

# 5.2

dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker compose up -d
WARN[0000] Found multiple config files with supported names: /home/dbn_usr/netology/docker/task5/compose.yaml, /home/dbn_usr/netology/docker/task5/docker-compose.yaml
WARN[0000] Using /home/dbn_usr/netology/docker/task5/compose.yaml
WARN[0000] /home/dbn_usr/netology/docker/task5/docker-compose.yaml: `version` is obsolete
WARN[0000] /home/dbn_usr/netology/docker/task5/compose.yaml: `version` is obsolete
[+] Running 4/4
 ✔ Container task5-portainer-1                                          Started                                                                                                                          3.0s
 ✔ Container task5-registry-1                                           Started                                                                                                                          3.0s
 ! portainer Published ports are discarded when using host network mode                                                                                                                                  0.0s
 ! registry Published ports are discarded when using host network mode                                                                                                                                   0.0s
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker compose ps
WARN[0000] Found multiple config files with supported names: /home/dbn_usr/netology/docker/task5/compose.yaml, /home/dbn_usr/netology/docker/task5/docker-compose.yaml
WARN[0000] Using /home/dbn_usr/netology/docker/task5/compose.yaml
WARN[0000] /home/dbn_usr/netology/docker/task5/docker-compose.yaml: `version` is obsolete
WARN[0000] /home/dbn_usr/netology/docker/task5/compose.yaml: `version` is obsolete
NAME                IMAGE                           COMMAND                  SERVICE     CREATED         STATUS         PORTS
task5-portainer-1   portainer/portainer-ce:latest   "/portainer"             portainer   9 seconds ago   Up 6 seconds
task5-registry-1    registry:2                      "/entrypoint.sh /etc…"   registry    9 seconds ago   Up 6 seconds
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ cat compose.yaml
version: "3"
include:
  - docker-compose.yaml
services:
  portainer:
    image: portainer/portainer-ce:latest
    network_mode: host
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock

dbn_usr@dbn-net-hw:~/netology/docker/task5$

# 5.3

dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker tag iveisberg/custom-nginx:1.0.0 localhost:5000/custom-nginx:latest
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker images
REPOSITORY                    TAG       IMAGE ID       CREATED         SIZE
iveisberg/custom-nginx        1.0.0     01eddee28694   4 days ago      864MB
localhost:5000/custom-nginx   latest    01eddee28694   4 days ago      864MB
debian                        latest    c69ac6bed067   2 weeks ago     117MB
portainer/portainer-ce        latest    a3f85c245ec3   2 months ago    293MB
registry                      2         6a3edb1d5eb6   9 months ago    25.4MB
hello-world                   latest    d2c94e258dcb   14 months ago   13.3kB
centos                        latest    5d0da3dc9764   2 years ago     231MB
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker push localhost:5000/custom-nginx:latest
The push refers to repository [localhost:5000/custom-nginx]
53699998b743: Pushed
d47e4d19ddec: Pushed
8e58314e4a4f: Pushed
ed94af62a494: Pushed
875b5b50454b: Pushed
63b5f2c0d071: Pushed
d000633a5681: Pushed
latest: digest: sha256:f41b4a086d4954b708242ef1ee5242a19a22c22d0511525ae64fb831efa909be size: 1783
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker images
REPOSITORY                    TAG       IMAGE ID       CREATED         SIZE
localhost:5000/custom-nginx   latest    01eddee28694   4 days ago      864MB
iveisberg/custom-nginx        1.0.0     01eddee28694   4 days ago      864MB
debian                        latest    c69ac6bed067   2 weeks ago     117MB
portainer/portainer-ce        latest    a3f85c245ec3   2 months ago    293MB
registry                      2         6a3edb1d5eb6   9 months ago    25.4MB
hello-world                   latest    d2c94e258dcb   14 months ago   13.3kB
centos                        latest    5d0da3dc9764   2 years ago     231MB
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker images
REPOSITORY               TAG       IMAGE ID       CREATED         SIZE
debian                   latest    c69ac6bed067   2 weeks ago     117MB
portainer/portainer-ce   latest    a3f85c245ec3   2 months ago    293MB
registry                 2         6a3edb1d5eb6   9 months ago    25.4MB
hello-world              latest    d2c94e258dcb   14 months ago   13.3kB
centos                   latest    5d0da3dc9764   2 years ago     231MB
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker pull localhost:5000/custom-nginx:latest
latest: Pulling from custom-nginx
a330b6cecb98: Pull complete
5ef80e6f29b5: Pull complete
f699b0db74e3: Pull complete
0f701a34c55e: Pull complete
3229dce7b89c: Pull complete
ddb78cb2d047: Pull complete
b5fd070b812f: Pull complete
Digest: sha256:f41b4a086d4954b708242ef1ee5242a19a22c22d0511525ae64fb831efa909be
Status: Downloaded newer image for localhost:5000/custom-nginx:latest
localhost:5000/custom-nginx:latest
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker images
REPOSITORY                    TAG       IMAGE ID       CREATED         SIZE
localhost:5000/custom-nginx   latest    01eddee28694   4 days ago      864MB
debian                        latest    c69ac6bed067   2 weeks ago     117MB
portainer/portainer-ce        latest    a3f85c245ec3   2 months ago    293MB
registry                      2         6a3edb1d5eb6   9 months ago    25.4MB
hello-world                   latest    d2c94e258dcb   14 months ago   13.3kB
centos                        latest    5d0da3dc9764   2 years ago     231MB
dbn_usr@dbn-net-hw:~/netology/docker/task5$

# 5.7

dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ mv -v compose.yaml ~/netology/docker/
renamed 'compose.yaml' -> '/home/dbn_usr/netology/docker/compose.yaml'
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ ls -alh
total 12K
drwxr-xr-x 2 dbn_usr dbn_usr 4.0K Jul  1 18:43 .
drwxr-xr-x 5 dbn_usr dbn_usr 4.0K Jul  1 18:43 ..
-rw-r--r-- 1 dbn_usr dbn_usr  110 Jul  1 11:01 docker-compose.yaml
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker compose up -d
WARN[0000] /home/dbn_usr/netology/docker/task5/docker-compose.yaml: `version` is obsolete
WARN[0000] Found orphan containers ([task5-portainer-1]) for this project. If you removed or renamed this service in your compose file, you can run this command with the --remove-orphans flag to clean it up.
[+] Running 1/0
 ✔ Container task5-registry-1  Running                                                                                                                                                                   0.0s
dbn_usr@dbn-net-hw:~/netology/docker/task5$

# Ошибка означает что контейнер "осиротел", т.е. не связан больше с определенным сервисом в файле конфигурации compose.yaml, т.к. сам файл манифеста переименован или удален. А команда "docker compose up -d --remove-orphans" удалит "осиротевший" контейнер при запуске.

dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker compose ps
WARN[0000] /home/dbn_usr/netology/docker/task5/docker-compose.yaml: `version` is obsolete
NAME                IMAGE                           COMMAND                  SERVICE     CREATED       STATUS          PORTS
task5-portainer-1   portainer/portainer-ce:latest   "/portainer"             portainer   3 hours ago   Up 36 minutes
task5-registry-1    registry:2                      "/entrypoint.sh /etc…"   registry    3 hours ago   Up 36 minutes
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docke compose up -d --remove-orphans
-bash: docke: command not found
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker compose up -d --remove-orphans
WARN[0000] /home/dbn_usr/netology/docker/task5/docker-compose.yaml: `version` is obsolete
[+] Running 2/1
 ✔ Container task5-portainer-1  Removed                                                                                                                                                                  0.7s
 ✔ Container task5-registry-1   Running                                                                                                                                                                  0.0s
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker compose ps
WARN[0000] /home/dbn_usr/netology/docker/task5/docker-compose.yaml: `version` is obsolete
NAME               IMAGE        COMMAND                  SERVICE    CREATED       STATUS          PORTS
task5-registry-1   registry:2   "/entrypoint.sh /etc…"   registry   3 hours ago   Up 47 minutes
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker compose down
WARN[0000] /home/dbn_usr/netology/docker/task5/docker-compose.yaml: `version` is obsolete
[+] Running 1/1
 ✔ Container task5-registry-1  Removed                                                                                                                                                                   0.8s
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$ docker compose ps
WARN[0000] /home/dbn_usr/netology/docker/task5/docker-compose.yaml: `version` is obsolete
NAME      IMAGE     COMMAND   SERVICE   CREATED   STATUS    PORTS
dbn_usr@dbn-net-hw:~/netology/docker/task5$
dbn_usr@dbn-net-hw:~/netology/docker/task5$

