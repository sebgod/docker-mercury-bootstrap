# vim: ft=dockerfile tw=78 ts=4 sw=4 et
FROM sebgod/mercury-depend:latest
MAINTAINER Sebastian Godelet <sebastian.godelet@outlook.com>
ENV MERCURY_TMP /var/tmp
RUN mkdir -p $MERCURY_TMP/tarballs
RUN mkdir -p $MERCURY_TMP/mercury
ENV MERCURY_RELEASE_URL http://dl.mercurylang.org/release
ENV MERCURY_ROTD_URL http://dl.mercurylang.org/rotd
ENV MERCURY_BOOTSTRAP_VERSION 2017-09-25
ENV MERCURY_BOOTSTRAP_TARGZ mercury-srcdist-rotd-${MERCURY_BOOTSTRAP_VERSION}.tar.gz
ADD $MERCURY_ROTD_URL/$MERCURY_BOOTSTRAP_TARGZ $MERCURY_TMP/tarballs/
ENV MERCURY_BOOTSTRAP_PREFIX /usr/local/mercury-bootstrap
ENV PATH_ORIG $PATH
ENV PATH ${MERCURY_BOOTSTRAP_PREFIX}/bin:$PATH_ORIG
WORKDIR $MERCURY_TMP/mercury
RUN tar --strip 1 -x -f $MERCURY_TMP/tarballs/$MERCURY_BOOTSTRAP_TARGZ \
    && (sh configure --enable-minimal-install \
            --enable-new-mercuryfile-struct \
            --prefix=$MERCURY_BOOTSTRAP_PREFIX > build.log \
        && make >> build.log \
        && make install >> build.log \
        && rm -fR * \
        ) || (cat build.log & false)
ENTRYPOINT ["mmc"]
