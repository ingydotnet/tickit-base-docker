#!/bin/sh

set -e
set -x

(
  apk add --update build-base bzr git libtool ncurses-dev wget
  apk add libtermkey-dev --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

  # XXX Dev:
  apk add --update bash ruby vim
  gem install gist || true

  wget http://www.leonerd.org.uk/code/libtermkey/libtermkey-0.18.tar.gz
  tar xzf libtermkey-0.18.tar.gz
  (
    cd libtermkey-0.18
    make install
  )

  git clone https://github.com/mauke/unibilium
  (
    cd unibilium
    mv maint.mk /tmp/
    make
    mv /tmp/maint.mk ./
    make install
  )

  bzr branch lp:libtickit
  (
    cd libtickit
    make install
  )

  echo DONE
) | tee /Docker.log
