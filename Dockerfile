FROM ruby:2.6.5-alpine

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo

WORKDIR /rails_app

COPY Gemfile .
COPY Gemfile.lock .

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