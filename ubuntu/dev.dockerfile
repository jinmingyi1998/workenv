FROM ubuntu:20.04

ENV TZ=Asia/Shanghai

COPY <<EOF /etc/apt/sources.list
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse

deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse
EOF
COPY <<EOF /etc/apt/sources.list.ustc
deb https://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse

deb https://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse

deb https://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse

deb https://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
EOF

RUN --mount=type=cache,target=/var/cache/apt \
--mount=type=cache,target=/var/lib/apt <<EOF
apt-get update 

DEBIAN_FRONTEND=noninteractive apt-get install -y \
    make gcc g++ automake patchelf \
    git git-lfs wget curl vim unzip zsh \
    tree ncdu htop tmux nnn nload jq language-pack-en language-pack-zh-hans \
    ca-certificates gpg sudo net-tools clang-format clangd openssh-server \
    zlib1g-dev libtool lsb-core libgmp-dev gfortran libgl1-mesa-dev ffmpeg libsm6 libxext6 \
    libva-dev libvdpau-dev libxcb1-dev libgles-dev libglx-dev libomp-dev libglfw3-dev libglew-dev
EOF
ENV RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
ENV CARGO_HOME=/opt/rust/.cargo
ENV RUSTUP_HOME=/opt/rust/.rust
RUN --mount=type=cache,target=/tmp <<EOF
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
EOF

ENV LC_ALL=en_US.UTF-8