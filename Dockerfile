FROM ubuntu:18.04

LABEL maintainer="fabian.gajek@gmail.com"

RUN apt-get update && apt-get install -y python3 python3-pip curl git

#install arm compiler (gnu-arm-none-eabi-6-2017-q2-update)
RUN curl -o /tmp/gcc.tar.bz2 -L https://developer.arm.com/-/media/Files/downloads/gnu-rm/6-2017q2/gcc-arm-none-eabi-6-2017-q2-update-linux.tar.bz2?revision=2cc92fb5-3e0e-402d-9197-bdfc8224d8a5?product=GNU%20Arm%20Embedded%20Toolchain,64-bit,,Linux,6-2017-q2-update
WORKDIR /gcc-arm
RUN tar -xif /tmp/gcc.tar.bz2
ENV PATH="/gcc-arm/gcc-arm-none-eabi-6-2017-q2-update/bin:${PATH}"
ENV MBED_GCC_ARM_PATH="/gcc-arm/gcc-arm-none-eabi-6-2017-q2-update/bin"

#install mbed cli
RUN pip3 install mbed-cli

#preinstall some mbed requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

WORKDIR /build