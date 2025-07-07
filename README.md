**Docker images of the Couchbase extension for PHP.**

## Docker Images

Docker images are available at Docker repository [deminy/php-couchbase]. Use the following commands to pull the images:

```bash
# Pull Couchbase 2 images.
docker pull --platform=linux/amd64 deminy/php-couchbase:2.6.2

# Pull Couchbase 3 images.
docker pull --platform=linux/amd64 deminy/php-couchbase:3.2.2-php7.4
docker pull --platform=linux/amd64 deminy/php-couchbase:3.2.2-php8.0
docker pull --platform=linux/amd64 deminy/php-couchbase:3.2.2-php8.1

# Pull Couchbase 4.2.x images.
docker pull deminy/php-couchbase:4.2.7-php8.0
# ...
docker pull deminy/php-couchbase:4.2.7-php8.3

# Pull Couchbase 4.3.x images.
docker pull deminy/php-couchbase:4.3.0-php8.1
# ...
docker pull deminy/php-couchbase:4.3.0-php8.4
```

The images use [phpswoole/swoole] as base images. Please refer to the [phpswoole/swoole] repository for more information
about how to use the images. For example, we can use commands like the following to check Couchbase installations:

```bash
# Check Couchbase 2 installation.
docker run --rm --platform=linux/amd64 -ti deminy/php-couchbase:2.6.2 php --ri couchbase

# Check Couchbase 3 installations.
docker run --rm --platform=linux/amd64 -ti deminy/php-couchbase:3.2.2-php7.4 php --ri couchbase
docker run --rm --platform=linux/amd64 -ti deminy/php-couchbase:3.2.2-php8.0 php --ri couchbase
docker run --rm --platform=linux/amd64 -ti deminy/php-couchbase:3.2.2-php8.1 php --ri couchbase

# Check Couchbase 4.2.x installations. Note that we have both AMD64 and ARM64 images built for Couchbase 4.2.x.
docker run --rm -ti deminy/php-couchbase:4.2.7-php8.0 php --ri couchbase
# ...
docker run --rm -ti deminy/php-couchbase:4.2.7-php8.3 php --ri couchbase

# Check Couchbase 4.3.x installations. Note that we have both AMD64 and ARM64 images built for Couchbase 4.3.x.
docker run --rm -ti deminy/php-couchbase:4.3.0-php8.1 php --ri couchbase
# ...
docker run --rm -ti deminy/php-couchbase:4.3.0-php8.4 php --ri couchbase
```

## Build Docker Images Locally

### Couchbase 2.6.2

```bash
docker build --platform=linux/amd64 -t deminy/php-couchbase:2.6.2-php7.4 dockerfiles/2.6.2/.
```

### Couchbase 3.2.2

```bash
docker build \
  --platform=linux/amd64 \
  --build-arg SWOOLE_IMAGE_TAG=4.8-php7.4 \
  --build-arg LIBCOUCHBASE_VERSION=3.3.17 \
  -t deminy/php-couchbase:3.2.2-php7.4 dockerfiles/3.2.2/.

docker build \
  --platform=linux/amd64 \
  --build-arg SWOOLE_IMAGE_TAG=5.1-php8.0 \
  -t deminy/php-couchbase:3.2.2-php8.0 dockerfiles/3.2.2/.

docker build \
  --platform=linux/amd64 \
  --build-arg SWOOLE_IMAGE_TAG=5.1-php8.1 \
  -t deminy/php-couchbase:3.2.2-php8.1 dockerfiles/3.2.2/.
```

### Couchbase 4.2.x

The Couchbase 4.2.x series works for both AMD64 and ARM64 architectures, and works with PHP 8.0 to 8.3.

```bash
export PHP_VERSION=8.2
export COUCHBASE_VERSION=4.2.7
export PHP_EXTENSION_DIR=no-debug-non-zts-20220829

docker build \
  --build-arg SWOOLE_IMAGE_TAG=5.1-php${PHP_VERSION} \
  --build-arg COUCHBASE_VERSION=${COUCHBASE_VERSION} \
  --build-arg PHP_EXTENSION_DIR=${PHP_EXTENSION_DIR} \
  -t deminy/php-couchbase:${COUCHBASE_VERSION}-php${PHP_VERSION} \
  ./dockerfiles/4.2.x/.
```

### Couchbase 4.3.x

The Couchbase 4.3.x series works for both AMD64 and ARM64 architectures, and works with PHP 8.1 to 8.4.

```bash
export PHP_VERSION=8.4
export COUCHBASE_VERSION=4.3.0
export PHP_EXTENSION_DIR=no-debug-non-zts-20240924

docker build \
  --build-arg SWOOLE_IMAGE_TAG=6.0-php${PHP_VERSION} \
  --build-arg COUCHBASE_VERSION=${COUCHBASE_VERSION} \
  --build-arg PHP_EXTENSION_DIR=${PHP_EXTENSION_DIR} \
  -t deminy/php-couchbase:${COUCHBASE_VERSION}-php${PHP_VERSION} \
  ./dockerfiles/4.3.x/.
```

## References

* Source code of the Couchbase extension
    * [php-couchbase]: for Couchbase 3 and below.
    * [couchbase-php-client]: for Couchbase 4.

[deminy/php-couchbase]: https://hub.docker.com/r/deminy/php-couchbase
[phpswoole/swoole]: https://github.com/swoole/docker-swoole
[php-couchbase]: https://github.com/couchbase/php-couchbase
[couchbase-php-client]: https://github.com/couchbase/couchbase-php-client
