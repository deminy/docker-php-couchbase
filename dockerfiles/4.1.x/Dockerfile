ARG SWOOLE_IMAGE_TAG

FROM phpswoole/swoole:${SWOOLE_IMAGE_TAG}

ARG COUCHBASE_VERSION
ENV COUCHBASE_VERSION=${COUCHBASE_VERSION}

RUN \
    set -ex && \
    apt-get update && \
    apt-get install cmake -y --no-install-recommends && \
    curl -sfL -o couchbase.tgz https://github.com/couchbase/couchbase-php-client/releases/download/${COUCHBASE_VERSION}/couchbase-${COUCHBASE_VERSION}.tgz && \
    tar zxvf couchbase.tgz && \
    cd couchbase-${COUCHBASE_VERSION} && \
    phpize && \
    ./configure && \
    make -j1 && \
    make install && \
    cd .. && \
    rm -rf couchbase-${COUCHBASE_VERSION} couchbase.tgz && \
    rm -rf /var/lib/apt/lists/* /tmp/*

FROM phpswoole/swoole:${SWOOLE_IMAGE_TAG}

ARG PHP_EXTENSION_DIR
ENV PHP_EXTENSION_DIR=${PHP_EXTENSION_DIR}

COPY --from=0 /usr/local/lib/php/extensions/${PHP_EXTENSION_DIR}/couchbase.so                /usr/local/lib/php/extensions/${PHP_EXTENSION_DIR}
COPY --from=0 /usr/local/lib/php/extensions/${PHP_EXTENSION_DIR}/libcouchbase_php_wrapper.so /usr/local/lib/php/extensions/${PHP_EXTENSION_DIR}

RUN \
    set -ex && \
    docker-php-ext-enable couchbase && \
    echo "swoole.use_shortname=Off" >> $(php-config --ini-dir)/docker-php-ext-swoole.ini && \
    rm -rf /var/lib/apt/lists/* /tmp/*
