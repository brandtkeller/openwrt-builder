Dockerfile
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    build-essential clang flex bison g++ gawk \
    gcc-multilib g++-multilib gettext git \
    libncurses5-dev libssl-dev python3-distutils \
    rsync unzip zlib1g-dev file wget curl ca-certificates \
    sudo time

RUN useradd -m builder
USER builder
WORKDIR /home/builder

CMD ["/bin/bash"]