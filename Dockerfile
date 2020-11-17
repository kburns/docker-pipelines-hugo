FROM alpine:latest
MAINTAINER Keaton Burns <keaton.burns@gmail.com>
# Based on pipelines-hugo from Karel Bemelmans

# Install AWS CLI and other necessary packages
RUN apk add --update --no-cache \
        bash \
        ca-certificates \
        curl \
        py-pip \
        py-pygments \
        wget &&\
    pip install -U awscli

# Set hugo version
ARG HUGO_VERSION=0.78.2
ARG HUGO_SHA256=6c139580bf42dd66615f61cb33d62fc47cb855790d744050d78924bf1f48df0d
ARG HUGO_URL=https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

# Install hugo
RUN curl -Ls ${HUGO_URL} -o /tmp/hugo.tar.gz &&\
    echo "${HUGO_SHA256}  /tmp/hugo.tar.gz" | sha256sum -c - &&\
    tar xf /tmp/hugo.tar.gz -C /tmp &&\
    mv /tmp/hugo /usr/bin/hugo &&\
    rm -rf /tmp/hugo*
