FROM alpine

COPY webdav.conf /etc/nginx/conf.d/webdav.conf

RUN apk update && \
    apk add --no-cache gcc make openssl-dev zlib-dev perl-dev pcre-dev libc-dev && \
    cd /tmp && \
    wget https://github.com/nginx/nginx/archive/master.zip && \
    unzip master.zip && \
    cd nginx-master && \
    ./auto/configure --prefix=/opt/nginx --with-http_dav_module && \
    make && make install && \
    cd /root && \
    apk del gcc make openssl-dev zlib-dev perl-dev pcre-dev libc-dev && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

VOLUME /media

EXPOSE 80

CMD /opt/nginx/sbin/nginx -g "daemon off;"

# COPY webdav.conf /etc/nginx/conf.d/webdav.conf
# docker hub 可以直接复制 github 中的代码

# apk add --no-cache gcc make openssl-dev zlib-dev perl-dev pcre-dev libc-dev
# 安装编译工具

# wget https://github.com/nginx/nginx/archive/master.zip
# 下载最新源码

# ./auto/configure --prefix=/opt/nginx --with-http_dav_module
# 编译安装到 /opt/nginx ，并增加 web_dav 模块，百度搜索的教程有误

# apk del gcc make openssl-dev zlib-dev perl-dev pcre-dev libc-dev
# 卸载编译工具，缩减镜像体积

# CMD /opt/nginx/sbin/nginx -g "daemon off;"
# 源码编译安装的 nginx 未加入环境变量，所以用绝对路径运行 nginx
# nginx 关闭后台运行，才能在 docker 中运行
