FROM alpine:latest
MAINTAINER Keaton Burns <keaton.burns@gmail.com>
# Based on pipelines-hugo from Karel Bemelmans

# Install AWS CLI and other necessary packages
RUN apk add --update --no-cache \
        bash \
        ca-certificates \
        curl \
        python \
        py-pip \
        py-pygments \
        wget &&\
    pip install -U awscli

# Set hugo version
ARG HUGO_VERSION=0.18.1
ARG HUGO_SHA256=cb462f41ff9620df89f69b85ccdea48cd789490bbab7a17d9c349dae76490add
ARG HUGO_URL=https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

# Install hugo
RUN curl -Ls ${HUGO_URL} -o /tmp/hugo.tar.gz &&\
    echo "${HUGO_SHA256}  /tmp/hugo.tar.gz" | sha256sum -c - &&\
    tar xf /tmp/hugo.tar.gz -C /tmp &&\
    mv /tmp/hugo*/hugo* /usr/bin/hugo &&\
    rm -rf /tmp/hugo*
