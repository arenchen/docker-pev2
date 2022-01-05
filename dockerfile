FROM node:12-alpine AS SOURCE

RUN apk add --update --no-cache curl openssl git yarn python2 build-base
RUN git config --global http.sslVerify false
RUN git config --global credential.helper store
RUN git clone https://github.com/dalibo/pev2.git
RUN cd pev2 && npm install && npm run build-app

FROM openresty/openresty:alpine

LABEL maintainer="Aren Chen <arenchen@netcorext.com>"
LABEL org.opencontainers.image.title="Postgres Explain Visualizer V2" \
    org.opencontainers.image.description="Run pev2 with Alpine, Nginx." \
    org.opencontainers.image.authors="Aren Chen <arenchen@netcorext.com>" \
    org.opencontainers.image.vendor="netcorext" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.version="0.24.0" \
    org.opencontainers.image.url="https://github.com/arenchen/pev2-docker" \
    org.opencontainers.image.source="https://github.com/arenchen/pev2-docker.git"

RUN echo -e 'server { \n \
    listen       80; \n \
    listen  [::]:80; \n \
    server_name  localhost; \n \
    location / { \n \
    root   /usr/share/nginx/html; \n \
    index  index.html; \n \
    try_files $uri /index.html; \n \
    } \n \
    error_page   500 502 503 504  /50x.html; \n \
    location = /50x.html { \n \
    root   /usr/share/nginx/html; \n \
    } \n \
    }' > /etc/nginx/conf.d/default.conf

COPY --from=SOURCE /pev2/dist-app/ /usr/share/nginx/html
