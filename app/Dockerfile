FROM cirrusci/flutter:dev AS build

WORKDIR /build

RUN flutter channel beta \
    && flutter upgrade \
    && flutter config --enable-web \
    && sudo apt-get update \
    && sudo apt-get install -y nginx \
    && sudo apt-get install -y chromium-browser \
    && sudo rm -rf /var/lib/apt/lists/*

COPY . .



