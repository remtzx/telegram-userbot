# We're using Arch Linux
FROM archlinux:latest

#
# Updating Arch
#
RUN pacman -Syu --noconfirm

#
# Installing Packages
#
RUN pacman -Syu --noconfirm \
    coreutils \
    bash \
    base-devel \
    bzip2 \
    curl \
    figlet \
    gcc \
    clang \
    git \
    sudo \
    aria2 \
    util-linux \
    libevent \
    libffi \
    libwebp \
    libxml2 \
    libxslt \
    linux-headers \
    musl \
    neofetch \
    postgresql \
    postgresql-client \
    postgresql-libs \
    openssl \
    pv \
    jq \
    wget \
    python \
    readline \
    sqlite \
    ffmpeg \
    sqlite \
    sudo \
    chromium \
    zlib \
    jpeg-archive \
    zip


RUN python3 -m ensurepip \
    && pip3 install --upgrade pip setuptools \
    && rm -r /usr/lib/python*/ensurepip && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

#
# Clone repo and prepare working directory
#
RUN git clone -b stable https://github.com/afdulfauzan/telegram-userbot /root/userbot
RUN mkdir /root/userbot/bin/
WORKDIR /root/userbot/

#
# Copies session and config (if it exists)
#
COPY ./sample_config.env ./userbot.session* ./config.env* /root/userbot/

#
# Install requirements
#
RUN pip3 install -r requirements.txt
CMD ["python3","-m","userbot"]
