FROM sebgod/mercury-depend:latest
MAINTAINER Sebastian Godelet <sebastian.godelet@outlook.com>
ENV MERCURY_BOOTSTRAP_VERSION 14.01.2-beta-2015-02-18
ENV MERCURY_SRCDIST http://dl.mercurylang.org/release/mercury-srcdist-
# ENV MERCURY_BOOTSTRAP_URL ${MERCURY_SRCDIST}${MERCURY_BOOTSTRAP_VERSION}.tar.gz
ENV MERCURY_BOOTSTRAP_URL https://onedrive.live.com/download?resid=46a5b17e36598e54%2140061
ENV MERCURY_BOOTSTRAP_PREFIX /usr/local/mercury-bootstrap
ENV PATH_ORIG $PATH
ENV PATH ${MERCURY_BOOTSTRAP_PREFIX}/bin:$PATH_ORIG
RUN mkdir -p /tmp/mercury
WORKDIR /tmp/mercury
RUN ( curl -s -L -N $MERCURY_BOOTSTRAP_URL | tar xz --strip 1 ) \
    && sh configure --enable-minimal-install \
        --enable-new-mercuryfile-struct \
        --prefix=${MERCURY_BOOTSTRAP_PREFIX} \
    && make \
    && make install \
    && make realclean \
    && aclocal -Im4 \
    && autoconf \
    && sh configure --enable-libgrades=asm_fast.gc \
        --enable-new-mercuryfile-struct \
    && make \
    && make install \
    && rm -fR *
ENTRYPOINT ["mmc"]
