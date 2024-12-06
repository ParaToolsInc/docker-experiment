# syntax=docker/dockerfile:1.4
# Stage 1. Check out LLVM source code and run the build.
FROM debian:12
# as builder
LABEL maintainer "ParaTools Inc."

# Install build dependencies of llvm.
# First, Update the apt's source list and include the sources of the packages.
# Improve caching too
RUN <<EOC
  grep deb /etc/apt/sources.list | sed 's/^deb/deb-src /g' >> /etc/apt/sources.list
  rm -f /etc/apt/apt.conf.d/docker-clean
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
EOC

ENV CCACHE_DIR=/ccache

# Install compiler, cmake, git, ccache etc.
RUN <<EOC
  apt-get update
  apt-get install -y --no-install-recommends ca-certificates \
    build-essential cmake ccache make python3 zlib1g wget unzip git
  cmake --version
EOC
