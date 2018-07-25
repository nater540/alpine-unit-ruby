#!/usr/bin/env bash

. /scripts/functions.sh

# Install base packages
apk --no-cache add \
  postgresql-client \
  ca-certificates \
  libressl \
  libxml2 \
  wget

# Install dumb-init as our process supervisor
wget --quiet -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64
chmod +x /usr/local/bin/dumb-init
