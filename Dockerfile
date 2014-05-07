FROM dockerfile/java
MAINTAINER Sebastian Godelet <sebastian.godelet+github@gmail.com>
RUN apt-get update
RUN apt-get install -y build-essential flex bison autoconf automake wget git curl
ENV MERCURY_BOOTSTRAP_VERSION rotd-2014-05-05
ENV PARALLEL -j4
RUN mkdir -p bootstrap-src && curl -s -L http://dl.mercurylang.org/rotd/mercury-srcdist-${MERCURY_BOOTSTRAP_VERSION}.tar.gz | tar -xzf - -C bootstrap-src --strip 1
RUN cd bootstrap-src && ls -la
RUN cd bootstrap-src && sh configure --enable-minimal-install
RUN cd bootstrap-src && make PARALLEL=${PARALLEL}
RUN cd bootstrap-src && make PARALLEL=${PARALLEL} install
ENV PATH_ORIG $PATH
ENV PATH /usr/local/mercury-${MERCURY_BOOTSTRAP_VERSION}/bin:$PATH_ORIG
