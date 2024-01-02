**Docker images of various versions of the Couchbase extension for PHP.**

## Build Docker Images

### Couchbase 2.6.2

```bash
docker build --platform=linux/amd64 -t deminy/php-couchbase:2.6.2-php7.4 dockerfiles/2.6.2/.
```

### Couchbase 3.2.2

```bash
docker build \
  --platform=linux/amd64 \
  --build-arg SWOOLE_IMAGE_TAG=4.8-php7.4 \
  --build-arg LIBCOUCHBASE_VERSION=3.3.10 \
  -t deminy/php-couchbase:3.2.2-php7.4 dockerfiles/3.2.2/.

docker build \
  --platform=linux/amd64 \
  --build-arg SWOOLE_IMAGE_TAG=4.8-php8.0 \
  -t deminy/php-couchbase:3.2.2-php8.0 dockerfiles/3.2.2/.

docker build \
  --platform=linux/amd64 \
  --build-arg SWOOLE_IMAGE_TAG=4.8-php8.1 \
  -t deminy/php-couchbase:3.2.2-php8.1 dockerfiles/3.2.2/.
```

### Couchbase 4.1.x

The Coucbhase 4.1.x series works with PHP 8.0 to 8.3.

```bash
export PHP_VERSION=8.2
export COUCHBASE_VERSION=4.1.5
export PHP_EXTENSION_DIR=no-debug-non-zts-20220829

docker build \
  --platform=linux/amd64 \
  --build-arg SWOOLE_IMAGE_TAG=5.1-php${PHP_VERSION} \
  --build-arg COUCHBASE_VERSION=${COUCHBASE_VERSION} \
  --build-arg PHP_EXTENSION_DIR=${PHP_EXTENSION_DIR} \
  -t deminy/php-couchbase:${COUCHBASE_VERSION}-php${PHP_VERSION} \
  ./dockerfiles/4.1.x/.
```

## References

* Source code of the Couchbase extension
    * [php-couchbase]: for Couchbase 3 and below.
    * [couchbase-php-client]: for Couchbase 4.

[php-couchbase]: https://github.com/couchbase/php-couchbase
[couchbase-php-client]: https://github.com/couchbase/couchbase-php-client
