FROM ubuntu:focal

RUN apt-get update && apt-get install -y \
    build-essential \
    automake \
    autoconf \
    libtool \
    wget \
    gfortran-7

RUN update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-7 7 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 7

WORKDIR /build

# compile lapack-3.10.1
RUN wget -c -O lapack-3.10.1.tar.gz https://github.com/Reference-LAPACK/lapack/archive/refs/tags/v3.10.1.tar.gz && \
    tar xf lapack-3.10.1.tar.gz && \
    cd lapack-3.10.1 && \
    cp INSTALL/make.inc.gfortran make.inc && \
    make lapacklib blaslib && \
    mkdir -p /usr/local/lapack/lib && \
    cp *.a /usr/local/lapack/lib

# Compile libxc-4.3.4
RUN wget -c -O libxc-4.3.4.tar.gz http://www.tddft.org/programs/libxc/down.php?file=4.3.4/libxc-4.3.4.tar.gz && \
    tar xf libxc-4.3.4.tar.gz && \
    cd libxc-4.3.4 && \
    autoreconf -i && \
    ./configure --prefix=/usr/local/libxc && \
    make && make install

WORKDIR /
RUN rm -rf /build
