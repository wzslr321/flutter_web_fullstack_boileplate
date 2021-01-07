FROM cirrusci/flutter:dev

WORKDIR /build

RUN flutter channel beta \
    && flutter upgrade \
    && flutter config --enable-web \
    && sudo apt-get update \
    && sudo apt-get install -y chromium-browser \
    && sudo rm -rf /var/lib/apt/lists/*

COPY . .

RUN  flutter pub get

CMD ["flutter", "run", "-d", "web-server", "--web-port", "8080"]