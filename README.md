## 👋 Welcome to web 🚀  

web README  
  
  
## Install my system scripts  

```shell
 sudo bash -c "$(curl -q -LSsf "https://github.com/systemmgr/installer/raw/main/install.sh")"
 sudo systemmgr --config && sudo systemmgr install scripts  
```
  
## Automatic install/update  
  
```shell
dockermgr update web
```
  
## Install and run container
  
```shell
dockerHome="/var/lib/srv/$USER/docker/casjaysdevdocker/web/web/latest/rootfs"
mkdir -p "/var/lib/srv/$USER/docker/web/rootfs"
git clone "https://github.com/dockermgr/web" "$HOME/.local/share/CasjaysDev/dockermgr/web"
cp -Rfva "$HOME/.local/share/CasjaysDev/dockermgr/web/rootfs/." "$dockerHome/"
docker run -d \
--restart always \
--privileged \
--name casjaysdevdocker-web-latest \
--hostname web \
-e TZ=${TIMEZONE:-America/New_York} \
-v "$dockerHome/data:/data:z" \
-v "$dockerHome/config:/config:z" \
-p 80:80 \
casjaysdevdocker/web:latest
```
  
## via docker-compose  
  
```yaml
version: "2"
services:
  ProjectName:
    image: casjaysdevdocker/web
    container_name: casjaysdevdocker-web
    environment:
      - TZ=America/New_York
      - HOSTNAME=web
    volumes:
      - "/var/lib/srv/$USER/docker/casjaysdevdocker/web/web/latest/rootfs/data:/data:z"
      - "/var/lib/srv/$USER/docker/casjaysdevdocker/web/web/latest/rootfs/config:/config:z"
    ports:
      - 80:80
    restart: always
```
  
## Get source files  
  
```shell
dockermgr download src casjaysdevdocker/web
```
  
OR
  
```shell
git clone "https://github.com/casjaysdevdocker/web" "$HOME/Projects/github/casjaysdevdocker/web"
```
  
## Build container  
  
```shell
cd "$HOME/Projects/github/casjaysdevdocker/web"
buildx 
```
  
## Authors  
  
🤖 casjay: [Github](https://github.com/casjay) 🤖  
⛵ casjaysdevdocker: [Github](https://github.com/casjaysdevdocker) [Docker](https://hub.docker.com/u/casjaysdevdocker) ⛵  
