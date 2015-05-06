FROM sebgod/mercury-depend:latest
MAINTAINER Sebastian Godelet <sebastian.godelet@outlook.com>
RUN mkdir -p /tmp/tarballs
RUN mkdir -p /tmp/mercury
ENV MERCURY_RELEASE_URL http://dl.mercurylang.org/release
ENV MERCURY_BOOTSTRAP_VERSION 14.01.2-beta-2015-02-18
ENV MERCURY_BOOTSTRAP_TARGZ mercury-srcdist-${MERCURY_BOOTSTRAP_VERSION}.tar.gz
ADD $MERCURY_RELEASE_URL/$MERCURY_BOOTSTRAP_TARGZ /tmp/tarballs/
ENV MERCURY_BOOTSTRAP_PREFIX /usr/local/mercury-bootstrap
ENV PATH_ORIG $PATH
ENV PATH ${MERCURY_BOOTSTRAP_PREFIX}/bin:$PATH_ORIG
WORKDIR /tmp/mercury
RUN tar xzf --strip 1 /tmp/tarballs/$MERCURY_BOOTSTRAP_TARGZ \
    && sh configure --enable-minimal-install \
        --enable-new-mercuryfile-struct \
        --prefix=$MERCURY_BOOTSTRAP_PREFIX \
    && make \
    && make install \
    && rm -fR *
ENTRYPOINT ["mmc"]
