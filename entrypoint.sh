#!/bin/sh -l

/composer/vendor/bin/phparkitect --version

IGNORE_PLATFORM_REQS=""
if [ "$CHECK_PLATFORM_REQUIREMENTS" = "false" ]; then
    IGNORE_PLATFORM_REQS="--ignore-platform-reqs"
fi

NO_DEV="--no-dev"
if [ "$REQUIRE_DEV" = "true" ]; then
    NO_DEV=""
fi

PHP_VERSION=""
if [ "PHP_VERSION" != "" ]; then
    PHP_VERSION=" --target-php-version=PHP_VERSION"
fi

COMPOSER_COMMAND="composer install --no-progress $NO_DEV $IGNORE_PLATFORM_REQS"
echo "::group::$COMPOSER_COMMAND"
$COMPOSER_COMMAND
echo "::endgroup::"
/composer/vendor/bin/phparkitect $* PHP_VERSION
