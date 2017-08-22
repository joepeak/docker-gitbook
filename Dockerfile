FROM node:8.4-alpine

MAINTAINER Joepeak <johe.heng@gmail.com>

ARG VERSION=2.6.7

LABEL version=$VERSION

RUN npm install --global gitbook-cli &&\
	gitbook fetch ${VERSION} &&\
	npm cache clear &&\
	rm -rf /tmp/*

WORKDIR /srv/gitbook

VOLUME /srv/gitbook /srv/html

EXPOSE 4000 35729

CMD /usr/local/bin/gitbook serve --gitbook=${VERSION}
