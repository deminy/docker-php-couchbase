#!/usr/bin/env ksh
#
# This script builds Docker images for the PHP Couchbase extension version 4.3.x.
#

set -e
set +x

# Check if at least one argument is provided, and the first argument starts with "4.3.".
if [[ $# -lt 1 || ! $1 =~ ^4\.3\. ]] ; then
    echo "Usage: $0 <couchbase_version>"
    echo "Example: $0 4.3.0"
    exit 1
fi

couchbase_version=$1
matrix=(
  ("8.1" "no-debug-non-zts-20210902")
  ("8.2" "no-debug-non-zts-20220829")
  ("8.3" "no-debug-non-zts-20230831")
  ("8.4" "no-debug-non-zts-20240924")
)

docker buildx create  --name docker-php-couchbase --driver-opt network=host --use
docker buildx inspect --bootstrap

for i in ${!matrix[@]}; do
    php_version=${matrix[i][0]}
    ext_dir=${matrix[i][1]}

    (set -x; docker buildx build --progress=plain \
      --platform linux/amd64,linux/arm64/v8 \
      --build-arg SWOOLE_IMAGE_TAG=6.0-php${php_version} \
      --build-arg COUCHBASE_VERSION=${couchbase_version} \
      --build-arg PHP_EXTENSION_DIR=${ext_dir} \
      --tag deminy/php-couchbase:${couchbase_version}-php${php_version} \
      --output=type=registry,registry.insecure=true \
      ./dockerfiles/4.3.x/)

    # Check the image manifest list from the registry:.
    (set -x; docker buildx imagetools inspect deminy/php-couchbase:${couchbase_version}-php${php_version})
done
