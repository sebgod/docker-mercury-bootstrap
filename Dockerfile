FROM sebgod/trusty-build-essential
MAINTAINER Sebastian Godelet <sebastian.godelet+github@gmail.com>
ENV MERCURY_BOOTSTRAP_VERSION rotd-2015-01-13
ENV PARALLEL -j4
RUN ( curl -s -L -N http://dl.mercurylang.org/rotd/mercury-srcdist-${MERCURY_BOOTSTRAP_VERSION}.tar.gz | tar xz --strip 1 ) && sh configure --enable-minimal-install && make PARALLEL=${PARALLEL} && make PARALLEL=${PARALLEL} install
ENV PATH_ORIG $PATH
ENV PATH /usr/local/mercury-${MERCURY_BOOTSTRAP_VERSION}/bin:$PATH_ORIG
ENTRYPOINT ["mmc"]
