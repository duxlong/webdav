# webdav

```Bash
docker run -d \
    -v /srv/dev-disk-by-label-2T/download:/media/download \
    -v /srv/dev-disk-by-label-3T/photo:/media/photo \
    -v /srv/dev-disk-by-label-3T/video:/media/video \
    -v /srv/dev-disk-by-label-3T/zoo:/media/zoo \
    -v /docker/webdav/htpasswd:/etc/nginx/htpasswd:ro \
    -p 8001:80 \
    --restart=always \
    --name=webdav \
    duxlong/webdav

```

运行容器前，需要[在线网站](https://tool.lu/htpasswd/)生成并配置好 `htpasswd `文件（默认 Md5 算法加密）
