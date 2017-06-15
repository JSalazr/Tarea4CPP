FROM ubuntu:15.04
MAINTAINER Pawel Szczur <public at pawelsz.eu>

LABEL description="A linux C++ build environment."

RUN apt-get update && apt-get install -y \
  gcc \
  clang \
  cmake \
  libboost-all-dev \
  g++ `#Fb folly deps` \
  automake \
  autoconf \
  autoconf-archive \
  libtool \
  libboost-all-dev \
  libcpprest-dev \
  libmagick++-dev \
  make \
  zlib1g-dev \
  binutils-dev \
  libssl-dev

ENV LD_LIBRARY_PATH=/libs
ENV CPLUS_INCLUDE_PATH=/libs/include

RUN mkdir /src
RUN mkdir /build
WORKDIR /build

RUN cd /home
RUN apt-get install -y wget
RUN apt-get install -y zip unzip
RUN wget https://github.com/JSalazr/Tarea4CPP/archive/master.zip
RUN unzip master.zip
RUN ldconfig
RUN cp -a Tarea4CPP-master/magick /usr/include
RUN cp -a Tarea4CPP-master/Magick++ /usr/include
RUN cp -a Tarea4CPP-master/Magick++.h /usr/include



EXPOSE 8080

CMD g++ Test.cpp base64.cpp -lcpprest -std=c++11 -o demo -lboost_system -lssl -lcrypto -lMagick++

