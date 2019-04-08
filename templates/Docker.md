# Docker

- [Docker](#docker)
  - [dockerfile - debian](#dockerfile---debian)
  - [Dockerfile php-apache2](#dockerfile-php-apache2)
  - [docker-compose nginx-redirection](#docker-compose-nginx-redirection)


## dockerfile - debian

```dockerfile
FROM debian:8.11

USER root
RUN mkdir -p /data
WORKDIR /data

# Téléchargement des outils necessaire
RUN echo "deb http://ftp.debian.org/debian unstable main contrib non-free" >> /etc/apt/sources.list && \
        echo "deb http://deb.debian.org/debian experimental main" >> /etc/apt/sources.list && \
        apt-get update && \
        apt-get install -y --allow-unauthenticated --fix-missing \
                openssh-server curl git wget nano && \
        curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
        apt-get install -y nodejs && curl -L https://npmjs.org/install.sh | sh && \
        rm -rf /var/lib/apt/lists/* && apt-get clean

USER debian

# Ports utilisés
EXPOSE ...

ENTRYPOINT ["..."]
CMD ["..."]
```

## Dockerfile php-apache2

```dockerfile
FROM php:7.0-apache
COPY ./app /var/www/html/
```

## docker-compose nginx-redirection

```docker-compose
version: '3'
services:

  # Application
  app:
    build: .
    networks:
    - app_network

  # Nginx pour redirection & https
  nginx:
    image: valian/docker-nginx-auto-ssl
    restart: on-failure
    ports:
      - 80:80
      - 443:443
    links:
    - "app:app"
    networks:
    - app_network
    volumes:
    - ./ssl-data:/etc/resty-auto-ssl
  env_file:
    - nginx.env
```
