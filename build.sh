#!/bin/sh

set -e
set -x

(
  finalize=${1:-false}

  apks="build-base bzr git libtool ncurses-dev"
  apks_dev="bash ruby vim"

  apk add --update $apks

  if ! $finalize; then
    apk add $apks_dev
    gem install gist || true
  fi

  apk add libtermkey-dev \
    --update-cache \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
    --allow-untrusted \

  wget http://www.leonerd.org.uk/code/libtermkey/libtermkey-0.18.tar.gz
  tar xzf libtermkey-0.18.tar.gz
  (
    cd libtermkey-0.18
    make install
  )
  rm -fr /libtermkey

  git clone https://github.com/mauke/unibilium
  (
    cd /unibilium
    mv maint.mk /tmp/
    make
    mv /tmp/maint.mk ./
    make install
  )
  rm -fr /unibilium

  bzr branch lp:libtickit
  (
    cd /libtickit
    make install
  )
  rm -fr /libtickit

  if $finalize; then
    apk del $apks
    apk del $apks_dev
    rm -fr /var/cache/apk/*
    rm -f /build.sh docker-build.log
  fi

  du -sh /
) 2>&1 | tee /docker-build.log
