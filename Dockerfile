FROM alpine:3.4
MAINTAINER Karel Bemelmans <mail@karelbemelmans.com>

# Install packages needed to build
RUN apk add --update --no-cache \
  bash \
  ca-certificates \
  curl \
  python \
  py-pip \
  wget \
  && pip install -U awscli

# Install hugo.
ARG HUGO_VERSION=0.18.1
ARG HUGO_SHA256=cb462f41ff9620df89f69b85ccdea48cd789490bbab7a17d9c349dae76490add

# Rember sha256sum (and md5sum) expect 2 spaces in front of the filename on alpine...
RUN curl -Ls https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
       -o /tmp/hugo.tar.gz \
  && echo "${HUGO_SHA256}  /tmp/hugo.tar.gz" | sha256sum -c - \
  && tar xf /tmp/hugo.tar.gz -C /tmp \
  && mv /tmp/hugo_${HUGO_VERSION}_linux_amd64/hugo_${HUGO_VERSION}_linux_amd64 /usr/bin/hugo \
  && rm -rf /tmp/hugo* \
