# syntax=docker/dockerfile:1
FROM base-image

# Tool chain for building
RUN apt-get update && apt-get install -y \
    build-essential \
    automake \
    autoconf \
    libtool \
    wget \
    gfortran-7 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ARG GNU_COMPILER_VERSION

RUN update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-${GNU_COMPILER_VERSION} 2 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GNU_COMPILER_VERSION} 2 

WORKDIR /build

ARG LAPACK_VERSION

RUN wget -c -O lapack.tar.gz https://github.com/Reference-LAPACK/lapack/archive/refs/tags/v${LAPACK_VERSION}.tar.gz && \
    mkdir -p lapack && \
    tar xf lapack.tar.gz -C lapack --strip-components=1 && \
    cd lapack && \
    cp INSTALL/make.inc.gfortran make.inc && \
    make lapacklib blaslib && \
    mkdir -p /usr/local/lapack/lib && \
    cp *.a /usr/local/lapack/lib

ARG LIBXC_VERSION
RUN wget -c -O libxc.tar.gz https://gitlab.com/libxc/libxc/-/archive/4.3.4/libxc-4.3.4.tar.gz && \
    mkdir -p libxc && \
    tar xf libxc.tar.gz -C libxc --strip-components=1 && \
    cd libxc && \
    autoreconf -i && \
    ./configure --prefix=/usr/local/libxc && \
    make && make install

RUN rm -rf /build
WORKDIR /
