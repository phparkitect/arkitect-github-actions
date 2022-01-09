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

TARGET_PHP_VERSION=""
if [ "TARGET_PHP_VERSION" != "" ]; then
    TARGET_PHP_VERSION=" --target-php-version=$TARGET_PHP_VERSION"
fi

COMPOSER_COMMAND="composer install --no-progress $NO_DEV $IGNORE_PLATFORM_REQS"
echo "::group::$COMPOSER_COMMAND"
$COMPOSER_COMMAND
echo "::endgroup::"
/composer/vendor/bin/phparkitect $* $TARGET_PHP_VERSION
