FROM ruby:2.4.3-alpine3.7

MAINTAINER ryuji41

ENV APP_ROOT /app

RUN apk add -U --no-cache \
  nodejs \
  binutils \
  dpkg-dev \
  g++ \
  gcc \
  make \
  zlib-dev \
  libpq \
  imagemagick \
  openssl \
  tzdata \
  git \
  sqlite-dev \
  linux-headers \
  bash \
  file

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN gem install bundler

RUN mkdir APP_ROOT
WORKDIR APP_ROOT

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
# Using hosts cache
ADD vendor/bundle vendor/bundle

RUN \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bundle config without test development doc \
  bundle install

ADD . $APP_ROOT

EXPOSE  3000

CMD ["rails", "server", "-b", "0.0.0.0"]
