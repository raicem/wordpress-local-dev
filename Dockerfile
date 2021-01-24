FROM ubuntu:20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    # To be able to download wp-cli via curl
    ca-certificates \
    curl \
    less \
    # mysql-client is needed for some wp-cli functionality
    mysql-client \ 
    php7.4-cli \
    php7.4-mysql \
    ; \
    rm -rf /var/lib/apt/lists/*;

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

WORKDIR /root/project

RUN wp --allow-root core download