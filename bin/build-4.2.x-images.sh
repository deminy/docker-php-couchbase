#!/usr/bin/env ksh
#
# This script builds Docker images for the PHP Couchbase extension version 4.2.x.
#
# Usage:
#   ./build-4.2.x-images.sh <couchbase_version>
# Example:
#   ./build-4.2.x-images.sh 4.2.7 2>&1 | tee ./build-4.2.7-images.log
#

set -e
set +x

# Check if at least one argument is provided, and the first argument starts with "4.2.".
if [[ $# -lt 1 || ! $1 =~ ^4\.2\. ]] ; then
    echo "Usage: $0 <couchbase_version>"
    echo "Example: $0 4.2.0"
    exit 1
fi

# Change to the root directory of the project.
CURRENT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd)
cd "${CURRENT_DIR}/.."

couchbase_version=$1
matrix=(
  ("8.0" "no-debug-non-zts-20200930")
  ("8.1" "no-debug-non-zts-20210902")
  ("8.2" "no-debug-non-zts-20220829")
  ("8.3" "no-debug-non-zts-20230831")
)

docker buildx rm -f --builder docker-php-couchbase || true
docker buildx create --name docker-php-couchbase --driver-opt network=host --use
docker buildx inspect --bootstrap

for i in ${!matrix[@]}; do
    php_version=${matrix[i][0]}
    ext_dir=${matrix[i][1]}

    (set -x; docker buildx build --progress=plain \
      --platform linux/amd64,linux/arm64/v8 \
      --build-arg SWOOLE_IMAGE_TAG=5.1-php${php_version} \
      --build-arg COUCHBASE_VERSION=${couchbase_version} \
      --build-arg PHP_EXTENSION_DIR=${ext_dir} \
      --tag deminy/php-couchbase:${couchbase_version}-php${php_version} \
      --output=type=registry,registry.insecure=true \
      ./dockerfiles/4.2.x/)

    # Check the image manifest list from the registry:.
    (set -x; docker buildx imagetools inspect deminy/php-couchbase:${couchbase_version}-php${php_version})
done
