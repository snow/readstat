FROM alpine:3.5

LABEL maintainer="jbn@falsifiable.com"

RUN apk add --update alpine-sdk autoconf automake build-base clang cmake \
    libtool make m4 zlib-dev git && \
    rm -rf /var/cache/apk/* 

WORKDIR /app

RUN git clone https://github.com/jmcnamara/libxlsxwriter.git && \
    cd libxlsxwriter && make && make install && \
    cd .. && rm -rf libxlsxwriter && \
    git clone https://github.com/WizardMac/ReadStat.git && \
    cd ReadStat && ./autogen.sh && ./configure && make && make install && \
    cd .. && rm -rf ReadStat

WORKDIR /data

ENTRYPOINT ["/usr/local/bin/readstat"]
