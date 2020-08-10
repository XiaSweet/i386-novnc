# 端口规划
# 9000 - nginx
# 9001 - websocketify
# 5901 - tigervnc

# based on ubuntu 18.04 LTS
FROM i386/ubuntu:latest

# 安装中文变量
RUN apt-get update \
	&& apt-get install -y language-pack-zh-hans
# 各种环境变量
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_ARG0=/sbin/entrypoint.sh \
    VNC_GEOMETRY=1000x600 \
    VNC_PASSWD=66666666 \
    USER_PASSWD='' \
    DEBIAN_FRONTEND=noninteractive

# 首先加用户，防止 uid/gid 不稳定
RUN groupadd user && useradd -m -g user user && \
    # 安装依赖和代码
    apt-get update && apt-get upgrade -y && \
    apt-get install -y \
        git \
        ca-certificates wget locales \
        nginx sudo \
        xorg xfce4 ttf-wqy-microhei  python-numpy rxvt-unicode && \
    wget -O - https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-x86.tar.gz | tar -xzv && \
    # workaround for https://github.com/just-containers/s6-overlay/issues/158
    ln -s /init /init.entrypoint && \
    # tigervnc
    wget -O /tmp/tigervnc.tar.gz https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.10.1.i386.tar.gz && \
    tar xzf /tmp/tigervnc.tar.gz -C /tmp && \
    chown root:root -R /tmp/tigervnc-1.10.1.i386 && \
    tar c -C /tmp/tigervnc-1.10.1.i386 usr | tar x -C / && \
    locale-gen zh_CN.UTF-8 && \
    # novnc
    mkdir -p /app/src && \
    git clone --depth=1 https://github.com/novnc/noVNC.git /app/src/novnc && \
    git clone --depth=1 https://github.com/novnc/websockify.git /app/src/websockify && \
    apt-get purge -y git wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -fr /tmp/* /app/src/novnc/.git /app/src/websockify/.git /var/lib/apt/lists

# copy files
COPY ./docker-root /

EXPOSE 9000/tcp 9001/tcp 5901/tcp

ENTRYPOINT ["/init.entrypoint"]
CMD ["start"]
