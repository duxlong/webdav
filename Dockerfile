FROM alpine

COPY nginx.conf /opt/nginx/conf/nginx.conf

RUN apk update && \
    apk add --no-cache pcre libxml2 libxslt && \
    apk add --no-cache gcc make libc-dev pcre-dev zlib-dev libxml2-dev libxslt-dev && \
    cd /tmp && \
    wget https://github.com/nginx/nginx/archive/master.zip -O nginx.zip && \
    unzip nginx.zip && \
    wget https://github.com/arut/nginx-dav-ext-module/archive/master.zip -O dav-ext-module.zip && \
    unzip dav-ext-module.zip && \
    cd nginx-master && \
    ./auto/configure --prefix=/opt/nginx --with-http_dav_module --add-module=/tmp/nginx-dav-ext-module-master && \
    make && make install && \
    cd /root && \
    apk del gcc make libc-dev pcre-dev zlib-dev libxml2-dev libxslt-dev && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

VOLUME /data

EXPOSE 80

CMD /opt/nginx/sbin/nginx -g "daemon off;"

# COPY nginx.conf /opt/nginx/conf/nginx.conf
# docker hub 可以直接复制 github 中的代码

# apk add --no-cache pcre libxml2 libxslt
# 安装 nginx 运行所必须的库

# apk add --no-cache gcc make libc-dev pcre-dev zlib-dev libxml2-dev libxslt-dev
# 安装编译工具

# wget https://github.com/nginx/nginx/archive/master.zip -O nginx.zip
# 下载 nginx 最新源码

# wget https://github.com/arut/nginx-dav-ext-module/archive/master.zip -O dav-ext-module.zip
# 下载 nginx-dav-ext-module 最新源码

# ./auto/configure --prefix=/opt/nginx --with-http_dav_module --add-module=/tmp/nginx-dav-ext-module-master
# 编译安装到 /opt/nginx ，并增加 web_dav 模块，网上教程有误

# apk del gcc make libc-dev pcre-dev zlib-dev libxml2-dev libxslt-dev
# 卸载编译工具，缩减镜像体积

# CMD /opt/nginx/sbin/nginx -g "daemon off;"
# 源码编译安装的 nginx 未加入环境变量，所以用绝对路径运行 nginx
# nginx 关闭后台运行，才能在 docker 中运行
