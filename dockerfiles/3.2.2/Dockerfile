ARG SWOOLE_IMAGE_TAG

FROM phpswoole/swoole:${SWOOLE_IMAGE_TAG}

ARG LIBCOUCHBASE_VERSION=3.3.16

RUN \
    set -ex && \
    apt-get update              && \
    apt-get install -y             \
        apt-transport-https        \
        gnupg                      \
        libzip4                    \
        libzip-dev                 \
        lsb-release                \
        --no-install-recommends && \
    curl -sfL http://ftp.br.debian.org/debian/pool/main/libe/libevent/libevent-core-2.1-7_2.1.12-stable-1_$(dpkg --print-architecture).deb -o libevent-core.deb && \
    dpkg -i libevent-core.deb && \
    curl -sfL https://github.com/couchbase/libcouchbase/releases/download/${LIBCOUCHBASE_VERSION}/libcouchbase-${LIBCOUCHBASE_VERSION}_debian$(lsb_release -rs)_$(lsb_release -cs)_$(dpkg --print-architecture).tar | tar -C . -x && \
    cd libcouchbase-${LIBCOUCHBASE_VERSION}_debian$(lsb_release -rs)_$(lsb_release -cs)_$(dpkg --print-architecture) && \
    dpkg -i                                                  \
        libcouchbase3-tools_${LIBCOUCHBASE_VERSION}-*.deb    \
        libcouchbase3-libevent_${LIBCOUCHBASE_VERSION}-*.deb \
        libcouchbase3_${LIBCOUCHBASE_VERSION}-*.deb          \
        libcouchbase-dev_${LIBCOUCHBASE_VERSION}-*.deb    && \
    cd - && \
    rm -rf libevent-core.deb libcouchbase-${LIBCOUCHBASE_VERSION}_debian$(lsb_release -rs)_$(lsb_release -cs)_$(dpkg --print-architecture) && \
    pecl channel-update pecl        && \
    pecl install couchbase-3.2.2    && \
    pecl install igbinary-3.2.16    && \
    docker-php-ext-enable couchbase && \
    rm -rf /var/lib/apt/lists/* /tmp/*
