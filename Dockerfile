FROM alpine:3.10

LABEL maintainer="jbn@falsifiable.com"

WORKDIR /app

RUN apk add --update alpine-sdk autoconf automake build-base clang cmake \
    libtool make m4 zlib-dev git gettext && \
    rm -rf /var/cache/apk/*

RUN git clone https://github.com/rgamble/libcsv.git && \
    cd libcsv && autoreconf -f -i && ./configure && make && make check && make install && \
    cd .. && rm -rf libcsv

RUN curl -O -L https://github.com/WizardMac/ReadStat/releases/download/v1.1.0/readstat-1.1.0.tar.gz && \
    tar xzf readstat-1.1.0.tar.gz && cd readstat-1.1.0 && \
    ./configure && make && make install && \
    cd .. && rm -rf readstat*

RUN apk del autoconf automake build-base clang cmake make m4 git

WORKDIR /data

ENTRYPOINT ["/usr/local/bin/readstat"]
