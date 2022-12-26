FROM ubuntu:22.04

ARG BUILD_TYPE[=Release]

RUN apt-get update
# RUN apt-get install tzdata -y
# RUN TZ="America/New_York"

RUN apt-get upgrade -y
RUN apt-get install -y \
    build-essential \
    clang \
    clang-format \
    clang-tidy \
    cmake \
    git \
    lib32ncurses5-dev \
    libbenchmark-dev \
    libblas-dev \
    libboost-program-options-dev \
    libgmp3-dev \
    libgtest-dev \
    libreadline-dev \
    libz-dev \
    ninja-build \
    wget

RUN git clone https://github.com/scipopt/soplex.git soplex
RUN cd soplex && cmake . -GNinja \
    -DBOOST=ON \
    -DBUILD_TESTING=OFF \
    -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
    -DGMP=OFF \
    -DMPFR=OFF \
    -DMT=OFF \
    -DPAPILO=OFF \
    -DQUADMATH=OFF \
    -DZLIB=ON
RUN cd soplex && ninja install


RUN git clone https://github.com/scipopt/scip.git scip
RUN cd scip && cmake . -GNinja \
    -DAUTOBUILD=OFF \
    -DBUILD_TESTING=OFF \
    -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
    -DDEBUGSOL=OFF \
    -DGMP=ON \
    -DIPOPT=OFF \
    -DLPS=spx \
    -DLPSCHECK=OFF \
    -DPAPILO=OFF \
    -DPARASCIP=OFF \
    -DREADLINE=OFF \
    -DSHARED=ON \
    -DTHREADSAFE=ON \
    -DUSE_GMP=OFF \
    -DWORHP=OFF \
    -DZIMPL=OFF \
    -DZLIB=ON
RUN cd scip && ninja install
