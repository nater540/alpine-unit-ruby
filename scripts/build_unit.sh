#!/usr/bin/env bash

. /scripts/functions.sh

apk --no-cache add \
  build-base \
  ruby-dev \
  git

git clone https://github.com/nginx/unit.git /tmp/nginx-unit

cd /tmp/nginx-unit
./configure --log=/var/log/unitd.log

if [ -x "$(command -v ruby)" ]; then
  ./configure ruby
  echo $(print_ok "Unit configured for Ruby")
fi

if [ -x "$(command -v php)" ]; then
  ./configure php
  echo $(print_ok "Unit configured for PHP")
fi

make all
make install
