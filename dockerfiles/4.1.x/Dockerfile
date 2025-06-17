ARG SWOOLE_IMAGE_TAG

FROM phpswoole/swoole:${SWOOLE_IMAGE_TAG} AS ext-couchbase

ARG COUCHBASE_VERSION

RUN \
    set -ex && \
    apt-get update && \
    apt-get install cmake -y --no-install-recommends && \
    curl -sfL -o couchbase.tgz https://github.com/couchbase/couchbase-php-client/releases/download/${COUCHBASE_VERSION}/couchbase-${COUCHBASE_VERSION}.tgz && \
    tar zxf couchbase.tgz && \
    cd couchbase-${COUCHBASE_VERSION} && \
    phpize && \
    ./configure && \
    make -j1 && \
    make install

FROM phpswoole/swoole:${SWOOLE_IMAGE_TAG} AS ext-igbinary

RUN pecl channel-update pecl && pecl install igbinary-3.2.16

FROM phpswoole/swoole:${SWOOLE_IMAGE_TAG}

ARG PHP_EXTENSION_DIR

COPY --from=ext-couchbase /usr/local/lib/php/extensions/${PHP_EXTENSION_DIR}/couchbase.so                /usr/local/lib/php/extensions/${PHP_EXTENSION_DIR}
COPY --from=ext-couchbase /usr/local/lib/php/extensions/${PHP_EXTENSION_DIR}/libcouchbase_php_wrapper.so /usr/local/lib/php/extensions/${PHP_EXTENSION_DIR}
COPY --from=ext-igbinary  /usr/local/lib/php/extensions/${PHP_EXTENSION_DIR}/igbinary.so                 /usr/local/lib/php/extensions/${PHP_EXTENSION_DIR}

RUN docker-php-ext-enable couchbase
