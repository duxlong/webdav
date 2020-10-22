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

CMD nginx -g "daemon off;"
