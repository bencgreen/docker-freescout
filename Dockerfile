FROM bcgdesign/nginx-php:php-7.4-1.2.2

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="FreeScout" \
    org.label-schema.version="latest" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ARG PHP_VERSION=7.4.15-r0

RUN apk -U upgrade \
    && apk add \
        php7-curl@edgecomm=${PHP_VERSION} \
        php7-gd@edgecomm=${PHP_VERSION} \
        php7-imap@edgecomm=${PHP_VERSION} \
        php7-json@edgecomm=${PHP_VERSION} \
        php7-mbstring@edgecomm=${PHP_VERSION} \
        php7-mysqli@edgecomm=${PHP_VERSION} \
        php7-xml@edgecomm=${PHP_VERSION} \
        php7-zip@edgecomm=${PHP_VERSION} \
    && rm -rf /var/cache/apk/* /www/* /tmp/*

COPY ./overlay /

VOLUME [ "/data" ]

ARG \
    # The FreeScout version to install
    FREESCOUT_VERSION=1.16.13

RUN apk add --virtual .install composer git \
    && chmod +x /tmp/install \
    && /tmp/install \
    && apk del .install \
    && rm -rf /var/cache/apk/* /tmp/*
