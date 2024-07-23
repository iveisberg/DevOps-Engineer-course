

sudo apt-get install docker.com


Dockerfile

FROM nginx:1.21.1
COPY . /index.html /usr/share/nginx/html/


sudo docker build -t iveisberg/custom-nginx:1.0.0 .

sudo docker push iveisberg/custom-nginx:1.0.0

sudo docker run -d -p 127.0.0.1:8080:80 --name=veisberg-igor-custom-nginx-t2 --restart=always 01eddee28694

sudo docker run -d -p 127.0.0.1:8080:80 --name=custom-nginx-t2 --restart=always 01eddee28694

sudo docker run -d -p 8080:80 --name=custom-nginx-t2 --restart=always 01eddee28694


sudo docker rename veisberg-igor-custom-nginx-t2 custom-nginx-t2

date +"%d-%m-%Y %T.%N %Z" ; sleep 0.150 ; sudo docker ps ; ss -tlpn | grep 127.0.0.1:8080  ; sudo docker logs custom-nginx-t2 -n1 ; sudo docker exec -it custom-nginx-t2 base64 /usr/share/nginx/html/index.html



Это дополнительное, необязательное задание. Попробуйте самостоятельно исправить конфигурацию контейнера, используя доступные источники в интернете.
Не изменяйте конфигурацию nginx и не удаляйте контейнер. Останавливать контейнер можно.
пример источника https://www.baeldung.com/ops/assign-port-docker-container#:~:text=Ways%20to%20Assign%20a%20New%20Port%20Mapping%20to%20a%20Running%20Container


dbn_usr@dbnnetologyhw:~$ sudo docker stop custom-nginx-t2
dbn_usr@dbnnetologyhw:~$ sudo systemctl status docker
dbn_usr@dbnnetologyhw:~$ sudo systemctl stop docker
dbn_usr@dbnnetologyhw:~$ sudo vim /var/lib/docker/containers/a8ace93bd4af68a6582cacc9add4c07fd2317fa972859282537a69dcc4bed703/hostconfig.json
dbn_usr@dbnnetologyhw:~$ sudo vim /var/lib/docker/containers/a8ace93bd4af68a6582cacc9add4c07fd2317fa972859282537a69dcc4bed703/config.v2.json

dbn_usr@dbnnetologyhw:~$ sudo grep -ir "hostport" /var/lib/docker/containers/a8ace93bd4af68a6582cacc9add4c07fd2317fa972859282537a69dcc4bed703/hostconfig.json
{"Binds":null,"ContainerIDFile":"","LogConfig":{"Type":"json-file","Config":{}},"NetworkMode":"default","PortBindings":{"80/tcp":[{"HostIp":"","HostPort":"8081"}]},"RestartPolicy":{"Name":"always","MaximumR

dbn_usr@dbnnetologyhw:~$ sudo grep -i "hostport" /var/lib/docker/containers/a8ace93bd4af68a6582cacc9add4c07fd2317fa972859282537a69dcc4bed703/config.v2.json
"Service":null,"Ports":{"80/tcp":[{"HostIp":"0.0.0.0","HostPort":"8081"},{"HostIp":"::","HostPort":"8081"}]},"SandboxKey":"/var/run/docker/netns/2414bd17d596","SecondaryIPAddresses":null,"SecondaryIPv6Addresses":null,"IsAnonymousEndpoint":false,"HasSwarmEndpoint":false},

dbn_usr@dbnnetologyhw:~$ sudo docker pull centos
dbn_usr@dbnnetologyhw:~$ sudo docker pull debian
dbn_usr@dbnnetologyhw:~$ sudo docker images
REPOSITORY               TAG       IMAGE ID       CREATED       SIZE
iveisberg/custom-nginx   1.0.0     01eddee28694   3 days ago    864MB
nginx                    1.0.0     01eddee28694   3 days ago    864MB
nginx                    latest    e0c9858e10ed   9 days ago    188MB
debian                   latest    c69ac6bed067   2 weeks ago   117MB
centos                   latest    5d0da3dc9764   2 years ago   231MB
nginx                    1.21.1    822b7ec2aaf2   2 years ago   133MB
dbn_usr@dbnnetologyhw:~$
dbn_usr@dbnnetologyhw:~$ sudo docker network create net-os
dbn_usr@dbnnetologyhw:~$ sudo docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
9f93fc0b909a   bridge    bridge    local
9784d6f0e083   host      host      local
e404fca245cf   net-os    bridge    local
3c609c06ae18   none      null      local
dbn_usr@dbnnetologyhw:~$


docker run -t -d -P --name debian-container --restart unless-stopped --network net-os -v /home/dbn_usr/netology/docker/task4:/data debian
docker run -t -d -P --name centos-container --restart=unless-stopped --network net-os -v /home/dbn_usr/netology/docker/task4:/data centos


dbn_usr@dbnnetologyhw:~/netology/docker/task4$ sudo docker build -t iveisberg/debian .

sudo docker run -d --name debian-container --privileged -v /home/dbn_usr:/data debian

sudo docker run -d -v /var/run/docker.sock:/var/run/docker.sock-v /home/dbn_usr:/data debian

sudo docker run -d -P --name veisberg-igor-custom-nginx-t2 --restart always --network net-os -v $(pwd):/data 

sudo docker run -d -P --restart=unless-stopped --network net-os debian




Скопируйте образ из Docker Hub в свой реестр

Вы можете получить образ из Docker Hub и отправить его в свой реестр. В следующем примере ubuntu:16.04образ извлекается из Docker Hub,
повторно помечает его как my-ubuntu, а затем отправляет в локальный реестр. Наконец, изображения ubuntu:16.04и my-ubuntuудаляются локально,
а my-ubuntuобраз извлекается из локального реестра.

Извлеките ubuntu:16.04образ из Docker Hub.

$ docker pull ubuntu:16.04

Пометьте образ как localhost:5000/my-ubuntu. Это создаст дополнительный тег для существующего образа. Когда первая часть тега — это имя хоста и порт,
Docker интерпретирует это как местоположение реестра при отправке.

$ docker tag ubuntu:16.04 localhost:5000/my-ubuntu

          docker tag iveisberg/custom-nginx:1.0.0 localhost:5000/custom-nginx:latest

Отправьте образ в локальный реестр по адресу localhost:5000:

$ docker push localhost:5000/my-ubuntu

          docker push localhost:5000/custom-nginx:latest

Удалите локально-кэшированные ubuntu:16.04 и localhost:5000/my-ubuntu образы, чтобы вы могли протестировать извлечение образа из вашего реестра.
Это не удалит образ localhost:5000/my-ubuntuиз вашего реестра.

$ docker image remove ubuntu:16.04
$ docker image remove localhost:5000/my-ubuntu

Загрузите localhost:5000/my-ubuntuизображение из вашего локального реестра.

$ docker pull localhost:5000/my-ubuntu

          docker pull localhost:5000/custom-nginx:latest






