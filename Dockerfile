FROM php:8.2-alpine

LABEL "com.github.actions.name"="PHPArkitect-arkitect"
LABEL "com.github.actions.description"="arkitect"
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/phparkitect/arkitect-github-actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Alessandro Minoccheri <alessandro.minoccheri@gmail.com>"

COPY --from=composer:2.5.5 /usr/bin/composer /usr/local/bin/composer

RUN mkdir /composer
ENV COMPOSER_HOME=/composer

RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini

ENV VERSION=0.3.32

RUN composer global require phparkitect/phparkitect $VERSION \
    && composer global require phpunit/phpunit \
    && composer global show "*phparkitect*"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
