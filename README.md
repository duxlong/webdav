# webdav

## Reference

http://nginx.org/en/docs/http/ngx_http_dav_module.html

https://github.com/arut/nginx-dav-ext-module

## Github

https://github.com/duxlong/webdav

## Docker hub

https://hub.docker.com/r/duxlong/webdav

## Usage

docker pull
```
docker pull duxlong/webdav
```

docker run（根据自己情况修改）
```
docker run -d \
    -v /srv/dev-disk-by-label-2T/download:/data/download \
    -v /srv/dev-disk-by-label-3T/photo:/data/photo \
    -v /srv/dev-disk-by-label-3T/video:/data/video \
    -v /srv/dev-disk-by-label-3T/zoo:/data/zoo \
    -v /docker/webdav/htpasswd:/opt/nginx/conf/htpasswd:ro \
    -p 8001:80 \
    --restart=unless-stopped \
    --name=webdav \
    duxlong/webdav
```

- 支持多用户；运行容器前，需要在线网站生成并配置好 `htpasswd` 文件（默认 Md5 算法加密）

- 把需要共享的文件挂载在 `/data` 目录下

- 把用户信息挂载在 `/opt/nginx/conf/htpasswd` 目录下

docker-compose（根据自己情况修改）
```
version: "2"
services:
  webdav:
    container_name: webdav
    image: duxlong/webdav
    network_mode: bridge
    restart: unless-stopped
    volumes:
      # 挂载共享文件夹
      - /srv/dev-disk-by-label-2T/download:/data/download
      - /srv/dev-disk-by-label-3T/photo:/data/photo
      - /srv/dev-disk-by-label-3T/video:/data/video
      - /srv/dev-disk-by-label-3T/zoo:/data/zoo
      # 挂载用户名和密码
      - /docker/webdav/htpasswd:/opt/nginx/conf/htpasswd:ro
    ports:
      - 8001:80
```
