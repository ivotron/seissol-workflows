FROM ubuntu:disco

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y \
      curl git \
      build-essential gfortran cmake \
      libeigen3-dev \
      libopenmpi-dev \
      libhdf5-dev libhdf5-mpi-dev \
      libparmetis-dev \
      virtualenv && \
    virtualenv -p python3 /scons && \
    bash -c 'source /scons/bin/activate && pip install numpy>=1.12.0 lxml scons' && \
    rm -rf /var/lib/apt/lists/*

# install libxsmm
RUN curl -LO https://github.com/hfp/libxsmm/archive/master.tar.gz && \
    tar xvfz master.tar.gz && \
    cd libxsmm-master && \
    make generator && \
    cp bin/libxsmm_gemm_generator /usr/bin && \
    cd / && \
    rm -rf libxsmm-master /var/lib/apt/lists/*

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
