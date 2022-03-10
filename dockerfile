FROM nginx:alpine

ENV PEV2_VERSION="0.24.0"

LABEL maintainer="Aren Chen <arenchen@netcorext.com>"
LABEL org.opencontainers.image.title="Postgres Explain Visualizer V2" \
    org.opencontainers.image.description="Run pev2 with Alpine, Nginx." \
    org.opencontainers.image.authors="Aren Chen <arenchen@netcorext.com>" \
    org.opencontainers.image.vendor="netcorext" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.version="${PEV2_VERSION}" \
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

RUN curl -sL https://github.com/dalibo/pev2/releases/download/v${PEV2_VERSION}/pev2.tar.gz | tar zx -C /usr/share/nginx/html --strip-components=1
