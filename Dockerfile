from debian:buster as base
RUN apt update &&\
    apt -y upgrade &&\
    apt install -y locales ca-certificates man-db &&\
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

from base as build
RUN apt -y install build-essential autoconf autoconf-archive automake autopoint gettext libssl-dev pkg-config txt2man gzip
ENV CFLAGS="-m64 -Os -pipe"
ADD axel /build
RUN cd /build &&\
    autoreconf -i &&\
    ./configure --disable-Werror &&\
    make -j$(nproc) &&\
    strip --strip-unneeded axel &&\
    gzip doc/axel.1

from base as runtime
COPY --from=build /build/axel /usr/local/bin/axel
COPY --from=build /build/doc/axel.1.gz /usr/share/man/man1/axel.1.gz
