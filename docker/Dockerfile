#syntax=docker/dockerfile:1.2

FROM ubuntu:bionic

RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt/lists \
    apt-get update && apt-get install --no-install-recommends --yes \
      curl \
      unzip \
      software-properties-common \
      python-minimal \
      python-configparser \
      make \
    && add-apt-repository ppa:fontforge/fontforge -y -u \
    && apt-get update \
    && apt-get install -y fontforge
