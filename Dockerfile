FROM node:11.6-alpine as node-11-angular-cli

LABEL authors="Sven Jepppsson"

ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1

RUN echo "http://dl-2.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk update \
    && apk -Uuv --no-cache --allow-untrusted add alpine-sdk zlib-dev git chromium xvfb wait4ports xorg-server dbus ttf-freefont grep udev groff less python py-pip make curl openssh \
    && ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime \
    && pip install awscli \
    && apk del --purge --force alpine-sdk linux-headers binutils-gold gnupg zlib-dev libc-utils py-pip \
    && rm -rf /var/lib/apt/lists/* \
    /var/cache/apk/* \
    /usr/share/man \
    /tmp/* \
    /*.tar.gz ~/.npm \
    /usr/lib/node_modules/npm/man \
    /usr/lib/node_modules/npm/doc \
    /usr/lib/node_modules/npm/html \
    /usr/lib/node_modules/npm/scriptsgit \
    && npm cache verify \
    && sed -i -e "s/bin\/ash/bin\/sh/" /etc/passwd \
    && npm install -g @angular/cli@7.1.4

