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

RUN mkdir -p /opt/miniconda3 && \
    wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /opt/miniconda3/miniconda.sh && \
    bash /opt/miniconda3/miniconda.sh -b -u -p /opt/miniconda3 && \
    rm -rf /opt/miniconda3/miniconda.sh
