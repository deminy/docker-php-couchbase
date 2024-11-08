ARG SWOOLE_IMAGE_TAG

FROM phpswoole/swoole:${SWOOLE_IMAGE_TAG} AS ext-couchbase

# Package couchbase-php-client v4.2.0+ requires CMake 3.19+; however, the official PHP 8.0 images have CMake 3.18.4 or
# lower installed. Thus, here we build CMake from source to satisfy the requirement.
ARG CMAKE_VERSION=3.29.0
ARG COUCHBASE_VERSION

RUN \
    set -ex && \
    apt-get update && \
    apt-get install git -y --no-install-recommends && \
    curl -sfL -o cmake.tar.gz https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz && \
    tar zxf cmake.tar.gz && \
    cd cmake-${CMAKE_VERSION} && \
    ./configure && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    curl -sfL -o couchbase.tgz https://github.com/couchbase/couchbase-php-client/releases/download/${COUCHBASE_VERSION}/couchbase-${COUCHBASE_VERSION}.tgz && \
    tar zxf couchbase.tgz && \
    cd couchbase-${COUCHBASE_VERSION} && \
    phpize && \
    ./configure && \
    make -j1 && \
    make install && \
    composer global require --no-progress --prefer-dist  couchbase/couchbase:~${COUCHBASE_VERSION}

FROM phpswoole/swoole:${SWOOLE_IMAGE_TAG} AS ext-igbinary

RUN pecl channel-update pecl && pecl install igbinary-3.2.15

FROM phpswoole/swoole:${SWOOLE_IMAGE_TAG}

ARG PHP_EXTENSION_DIR

COPY --from=ext-couchbase /usr/local/lib/php/extensions/${PHP_EXTENSION_DIR}/couchbase.so /usr/local/lib/php/extensions/${PHP_EXTENSION_DIR}
COPY --from=ext-igbinary  /usr/local/lib/php/extensions/${PHP_EXTENSION_DIR}/igbinary.so  /usr/local/lib/php/extensions/${PHP_EXTENSION_DIR}

RUN docker-php-ext-enable couchbase
