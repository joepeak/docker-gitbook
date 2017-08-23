FROM mhart/alpine-node:8.4

MAINTAINER Joepeak <johe.heng@gmail.com>

ARG VERSION=3.2.3

LABEL version=$VERSION

# install fonts Noto Sans CJK SC for Simplified Chinese
#RUN wget -P /raw_fonts https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKsc-hinted.zip && \
#    cd /raw_fonts && \
#    mkdir /usr/share/fonts/noto && \
#    unzip -o NotoSansCJKsc-hinted.zip && \
#    mv -t /usr/share/fonts/noto *-DemiLight.otf *-Bold.otf *-Black.otf && \
#    rm -r /raw_fonts && \
#    fc-cache -f -v

## Install Calibre
#RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list && \
#    apt-get update && \
#    apt-get install -y --no-install-recommends calibre fonts-noto fonts-noto-cjk locales-all && \
#    rm -rf /var/lib/apt/lists/*
    
RUN npm install --global gitbook-cli ebook-convert svgexport sqlite3 nodejieba &&\
	gitbook fetch ${VERSION} &&\
	npm cache clear &&\
	rm -rf /root/.npm /tmp/*

ENV BOOKDIR=/srv/gitbook  HTMLDIR=/srv/html

VOLUME $BOOKDIR $HTMLDIR

WORKDIR $BOOKDIR

EXPOSE 4000 35729

CMD ["gitbook", "serve"]
