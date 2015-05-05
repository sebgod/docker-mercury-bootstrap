FROM sebgod/mercury-depend:latest
MAINTAINER Sebastian Godelet <sebastian.godelet@outlook.com>
ENV MERCURY_BOOTSTRAP_VERSION rotd-2015-04-24
ENV MERCURY_BASE_URL http://dl.mercurylang.org
ENV MERCURY_BOOTSTRAP_URL ${MERCURY_BASE_URL}/rotd/mercury-srcdist-${MERCURY_BOOTSTRAP_VERSION}.tar.gz
ENV PARALLEL -j4
RUN ( curl -s -L -N $MERCURY_BOOTSTRAP_URL | tar xz --strip 1 ) \
    && sh configure --enable-libgrades=asm_fast.gc \
        --enable-new-mercuryfile-struct \
    && make PARALLEL=${PARALLEL} \
    && make PARALLEL=${PARALLEL} install \
    && make realclean
ENV PATH_ORIG $PATH
ENV PATH /usr/local/mercury-${MERCURY_BOOTSTRAP_VERSION}/bin:$PATH_ORIG
ENTRYPOINT ["mmc"]
