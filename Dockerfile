FROM ubuntu:18.04

LABEL maintainer="fabian.gajek@gmail.com"

RUN apt-get update && apt-get install -y \
    python3 python3-pip curl git \
    && rm -rf /var/lib/apt/lists/*

#install arm compiler (gcc-arm-none-eabi-9-2019-q4-major)
WORKDIR /gcc-arm
RUN curl -o /tmp/gcc.tar.bz2 -L "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/RC2.1/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2?revision=6e63531f-8cb1-40b9-bbfc-8a57cdfc01b4&la=en&hash=F761343D43A0587E8AC0925B723C04DBFB848339&" \
    && tar -xif /tmp/gcc.tar.bz2 \
    && rm /tmp/gcc.tar.bz2

ENV PATH="/gcc-arm/gcc-arm-none-eabi-9-2019-q4-major/bin:${PATH}"
ENV MBED_GCC_ARM_PATH="/gcc-arm/gcc-arm-none-eabi-9-2019-q4-major/bin"

#install mbed cli
RUN pip3 install mbed-cli

#preinstall some mbed requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

WORKDIR /build