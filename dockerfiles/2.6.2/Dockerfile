FROM phpswoole/swoole:4.8-php7.4

# To find available packages, use following commands:
#   apt-cache showpkg libcouchbase-dev
#   apt-cache policy  libcouchbase-dev
RUN \
    set -ex && \
    apt-get update              && \
    apt-get install -y             \
        apt-transport-https        \
        gnupg                      \
        --no-install-recommends && \
    curl -sfL http://packages.couchbase.com/ubuntu/couchbase.key | apt-key add -                                && \
    echo "deb http://packages.couchbase.com/ubuntu bionic bionic/main" > /etc/apt/sources.list.d/couchbase.list && \
    apt-get update              && \
    apt-get install -y             \
        libcouchbase-dev=2.10.6-1  \
        libzip-dev                 \
        --no-install-recommends && \
    pecl channel-update pecl        && \
    pecl install couchbase-2.6.2    && \
    pecl install igbinary-3.2.16    && \
    docker-php-ext-enable couchbase && \
    rm -rf /var/lib/apt/lists/* /tmp/*
