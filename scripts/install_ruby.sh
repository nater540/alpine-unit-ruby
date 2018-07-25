#!/usr/bin/env bash

. /scripts/functions.sh

# Disable documentation, install messages and suggestions when installing gems
mkdir -p /usr/local/etc && \
  { \
		echo 'install: --no-document --no-post-install-message --no-suggestions'; \
		echo 'update: --no-document --no-post-install-message --no-suggestions'; \
    echo 'gem: --no-document --no-post-install-message --no-suggestions'; \
	} >> /usr/local/etc/gemrc && \
  chmod uog+r /usr/local/etc/gemrc

# Install ruby packages
apk --no-cache add \
  ruby-bigdecimal \
  ruby-io-console \
  ruby-bundler \
  ruby-json \
  ruby-irb \
  ruby-etc \
  ruby-ffi \
  ruby

gem install --no-document rack
