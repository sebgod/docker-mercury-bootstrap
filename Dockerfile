FROM dockerfile/java
MAINTAINER Sebastian Godelet <sebastian.godelet+github@gmail.com>
RUN apt-get update
RUN apt-get install -y build-essential flex bison autoconf automake wget git curl
ENV MERCURY_VERSION 14.01
ENV PARALLEL -j4
RUN curl -s -L http://dl.mercurylang.org/release/mercury-srcdist-${MERCURY_VERSION}.tar.gz | tar xz
RUN mv mercury-srcdist-${MERCURY_VERSION} src
WORKDIR src
RUN ./configure --enable-minimal-install 
RUN make PARALLEL=${PARALLEL}
RUN make PARALLEL=${PARALLEL} install
ENV PATH_ORIG $PATH
ENV PATH /usr/local/mercury-${MERCURY_VERSION}/bin:$PATH_ORIG
