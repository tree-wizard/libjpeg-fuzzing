#libjpeg-turbo afl
#Base Image is standard ubuntu build
FROM ubuntu:latest

#Install dependencies and utilities
RUN apt-get update
RUN apt-get --yes install cmake git nasm wget gnupg


#Install Clang
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key| apt-key add -
RUN apt-get update
RUN apt-get --yes install clang-6.0 lldb-6.0 lld-6.0 libfuzzer-6.0-dev 

ENV CC=clang-6.0
ENV CXX=clang++-6.0
#ENV CFLAGS='-fsanitize=fuzzer-no-link -g'
#ENV CXXFLAGS='-fsanitize=fuzzer-no-link -g'


RUN git clone https://github.com/libjpeg-turbo/libjpeg-turbo/
RUN cd libjpeg-turbo/ && cmake -G"Unix Makefiles" #-DCMAKE_C_FLAGS="-fsanitize=fuzzer-no-link, -fPIC -g" -DCMAKE_CXX_FLAGS=-fsanitize=fuzzer-no-link, -fPIC -g"

RUN cd libjpeg-turbo/ && make install

RUN git clone https://github.com/xxyyx/libjpeg-fuzzing/

