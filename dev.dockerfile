FROM ubuntu:20.04

ENV TZ=Asia/Shanghai

COPY sources.list.tuna /etc/apt/sources.list

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git git-lfs wget curl vim unzip zsh \
    tree ncdu htop tmux nnn nload jq language-pack-en language-pack-zh-hans \
    ca-certificates gpg sudo net-tools clang-format clangd \
    make gcc g++ zlib1g-dev libtool lsb-core automake libgmp-dev gfortran  && \
    rm -rf /var/lib/apt/lists/*

ENV LC_ALL=en_US.UTF-8