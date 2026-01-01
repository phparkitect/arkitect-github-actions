#!/bin/sh -l

set -e

echo "::group::PHPArkitect Version"
/composer/vendor/bin/phparkitect --version
echo "::endgroup::"

# Build composer install flags
COMPOSER_FLAGS="--no-progress --no-interaction"

if [ "${CHECK_PLATFORM_REQUIREMENTS}" = "false" ]; then
    COMPOSER_FLAGS="${COMPOSER_FLAGS} --ignore-platform-reqs"
fi

if [ "${REQUIRE_DEV}" != "true" ]; then
    COMPOSER_FLAGS="${COMPOSER_FLAGS} --no-dev"
fi

# Install project dependencies if composer.json exists
if [ -f "composer.json" ]; then
    echo "::group::Installing project dependencies"
    # shellcheck disable=SC2086
    composer install ${COMPOSER_FLAGS}
    echo "::endgroup::"
else
    echo "::notice::No composer.json found, skipping dependency installation"
fi

# Build PHPArkitect flags
PHPARKITECT_FLAGS=""
if [ -n "${PHP_VERSION}" ]; then
    PHPARKITECT_FLAGS="--target-php-version=${PHP_VERSION}"
    echo "::notice::Analyzing code for PHP ${PHP_VERSION} compatibility"
fi

# Execute PHPArkitect with all arguments
echo "::group::Running PHPArkitect"
# shellcheck disable=SC2086
/composer/vendor/bin/phparkitect "$@" ${PHPARKITECT_FLAGS}
echo "::endgroup::"
