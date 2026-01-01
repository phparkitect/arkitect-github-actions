FROM php:8.2-alpine

# Modern OCI labels
LABEL org.opencontainers.image.title="PHPArkitect GitHub Action"
LABEL org.opencontainers.image.description="Enforce architectural rules in PHP projects using PHPArkitect"
LABEL org.opencontainers.image.source="https://github.com/phparkitect/arkitect-github-actions"
LABEL org.opencontainers.image.url="https://github.com/phparkitect/arkitect-github-actions"
LABEL org.opencontainers.image.documentation="https://github.com/phparkitect/arkitect-github-actions/blob/main/README.md"
LABEL org.opencontainers.image.vendor="PHPArkitect"
LABEL org.opencontainers.image.licenses="MIT"
LABEL maintainer="Alessandro Minoccheri <alessandro.minoccheri@gmail.com>"

# Install git (required for Composer) and other dependencies
RUN apk add --no-cache git unzip

# Use latest Composer version
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN mkdir /composer
ENV COMPOSER_HOME=/composer
ENV PATH="/composer/vendor/bin:${PATH}"

# Configure PHP
RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini

# PHPArkitect version
ARG VERSION=0.7.0
ENV VERSION=${VERSION}

# Install PHPArkitect globally
RUN composer global require phparkitect/phparkitect:${VERSION} --no-interaction --prefer-dist \
    && composer global show phparkitect/phparkitect

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
