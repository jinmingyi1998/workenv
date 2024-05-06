FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    TZ=Asia/Shanghai \
    PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=utf-8
COPY <<EOF /etc/apt/sources.list 
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
EOF

RUN --mount=type=cache,target=/var/cache/apt <<EOF
rm /etc/apt/sources.list.d/*
apt-get update --allow-unauthenticated
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    make gcc g++ automake patchelf build-essential ccache bash \
    wget curl vim pigz zip unzip chrpath \
    ca-certificates gpg sudo openssh-server \
    python3 python3-dev python3-pip parallel \
    git git-lfs sudo tzdata \
    zlib1g-dev libtool lsb-core libgl1-mesa-dev libsm6 libxext6 \
    libva-dev libvdpau-dev libxcb1-dev libgles-dev libglx-dev \
    libomp-dev libglfw3-dev libglew-dev libtcmalloc-minimal4 \
    libssl-dev libre2-dev swig yasm libopenmpi-dev openmpi-bin \
    libnuma-dev rapidjson-dev libb64-dev libarchive-dev libtbb2    
EOF

RUN localedef -i en_US -f UTF-8 en_US.UTF-8
COPY <<EOF /root/.config/pip/pip.conf 
[global]
index-url = https://mirrors.ustc.edu.cn/pypi/web/simple
EOF

RUN --mount=type=cache,target=/root/.cache <<EOF
python3 -m pip install -U pip wheel setuptools virtualenv
mkdir -p /opt/venv
EOF

RUN --mount=type=cache,target=/var/cache/apt <<EOF
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    tree ncdu tmux rsync \
    netcat socat pv net-tools telnet iputils-ping \
    zsh xz-utils iftop htop iotop sysstat \
    moreutils supervisor
EOF

RUN virtualenv --prompt trtllm /opt/venv/trtllm
ENV PATH=/opt/venv/trtllm/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/venv/trtllm/lib:$LD_LIBRARY_PATH
ENV OMP_NUM_THREADS=8
ENV OPENBLAS_NUM_THREADS=8

COPY requirements.txt /tmp/requirements.txt
RUN --mount=type=cache,target=/root/.cache <<EOF
pip install torch torchvision torchaudio -i https://download.pytorch.org/whl/cu121
pip install -r /tmp/requirements.txt --no-deps
pip install tensorrt==9.3.0.post12.dev1 \
tensorrt-bindings==9.3.0.post12.dev1 \
tensorrt-libs==9.3.0.post12.dev1 \
tensorrt-llm==0.10.0.dev2024043000 \
-U --pre --extra-index-url https://pypi.nvidia.com --no-deps
EOF