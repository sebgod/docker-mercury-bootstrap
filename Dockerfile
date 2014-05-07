FROM sebgod/trusty-build-essential
MAINTAINER Sebastian Godelet <sebastian.godelet+github@gmail.com>
ENV MERCURY_BOOTSTRAP_VERSION rotd-2014-05-05
ENV PARALLEL -j4
RUN mkdir -p bootstrap-src && ls -la && curl -s -L http://dl.mercurylang.org/rotd/mercury-srcdist-${MERCURY_BOOTSTRAP_VERSION}.tar.gz | tar -xzf - -C bootstrap-src --strip 1
RUN cd bootstrap-src && ls -la
RUN cd bootstrap-src && sh configure --enable-minimal-install
RUN cd bootstrap-src && make PARALLEL=${PARALLEL}
RUN cd bootstrap-src && make PARALLEL=${PARALLEL} install
ENV PATH_ORIG $PATH
ENV PATH /usr/local/mercury-${MERCURY_BOOTSTRAP_VERSION}/bin:$PATH_ORIG
