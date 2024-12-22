#!/usr/bin/env bash

GIT_TAG=$1

if [[ "$(ldd /bin/ls)" == *musl* ]] ; then
    libc=musl
else
    libc=gnu
fi
arch=$(uname -m)
curl -sSL "https://github.com/atuinsh/atuin/releases/download/${GIT_TAG}/atuin-${arch}-unknown-linux-${libc}.tar.gz" | tar -xz --strip-components 1
