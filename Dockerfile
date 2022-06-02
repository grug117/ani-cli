FROM alpine:3 AS build

RUN apk add --no-cache \
    grep \
    sed \
    curl \
    openssl \
    mpv \
    aria2 \
    ffmpeg

COPY ./ani-cli /usr/local/bin/ani-cli
RUN chmod +x /usr/local/bin/ani-cli

COPY ./download.sh ./download.sh
RUN chmod +x ./download.sh

VOLUME /download
ENV DOWNLOAD_DIR /download

ENTRYPOINT ["/bin/sh", "./download.sh"]
