FROM ruby:2.6.5-alpine

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo

WORKDIR /rails_app

COPY Gemfile .
COPY Gemfile.lock .

# [: "hogehoge"] はコメントの代わり。コマンド途中で"#" でコメント挟めないので 
RUN apk update && apk add --no-cache \
      yarn \
      tzdata \
      libxml2-dev \
      curl-dev \
      make \
      gcc \
      libc-dev \
      g++ \
      mariadb-dev \
      imagemagick6-dev && \
    : "コンテナ内でGoogle Chromeを使えるようにする" && \
    apk add --no-cache \
      chromium-chromedriver \
      zlib-dev \
      chromium \
      xvfb \
      wait4ports \
      xorg-server \
      dbus \
      ttf-freefont \
      mesa-dri-swrast \
      udev && \
    bundle install -j4 --retry=3 && \
    rm -rf /usr/local/bundle/cache/* \
      /usr/local/share/.cache/* \
      /var/cache/* /tmp/* && \
    apk del \
      libxml2-dev \
      curl-dev \
      make \
      gcc \
      libc-dev \
      g++

COPY . /rails_app