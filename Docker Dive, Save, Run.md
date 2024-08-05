## docker dive -> save

#https://github.com/wagoodman/dive
dive test_extract

docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive  test_extract  #запуск может занять до 30 сек

docker image save -o /tmp/image.tar.gz test_extract 
tar xf /tmp/image.tar.gz

cd blobs/sha256

# Digest: sha256:f8194172658e9ce6e7923639c5ebd4f77a8a7a2b44b1e1462a110f793c17c280

tar xf f8194172658e9ce6e7923639c5ebd4f77a8a7a2b44b1e1462a110f793c17c280


## docker cp

Examples
Copy a local file into container
 docker cp ./some_file CONTAINER:/work

Copy files from container to local path
 docker cp CONTAINER:/var/logs/ /tmp/app_logs

Copy a file from container to stdout. Note cp command produces a tar stream
 docker cp CONTAINER:/var/logs/app.log - | tar x -O | grep "ERROR"

---

docker run -d hashicorp/terraform
910997eeb44a72d1b10c30744395e2f63201b9abcb18d96e11bec6ba0a88ce48

docker ps -a
CONTAINER ID   IMAGE                           COMMAND                  CREATED         STATUS                       PORTS                                 NAMES
910997eeb44a   hashicorp/terraform             "/bin/terraform"         4 seconds ago   Exited (127) 2 seconds ago                                         nostalgic_borg

docker cp nostalgic_borg:/bin/terraform /tmp/
Successfully copied 89MB to /tmp/

ls -alh /tmp/
-rwxr-xr-x  1 dbn_usr dbn_usr  85M Jul 25 00:58 terraform
------------------------------------------

