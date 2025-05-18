# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.3.0
FROM ruby:$RUBY_VERSION-slim as base

WORKDIR /myapp

ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle"

# 共通パッケージ
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libvips \
    libpq-dev \
    default-libmysqlclient-dev \
    nodejs \
    yarn \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Gemインストール（Gemfile更新時のみ再ビルド）
COPY Gemfile Gemfile.lock ./
RUN bundle install

# 必要なディレクトリ作成と権限設定
RUN mkdir -p tmp/pids tmp/cache tmp/sockets log && \
    chown -R root:root /myapp && \
    chmod -R 755 /myapp

EXPOSE 3000

# Webサーバを外部に公開
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
