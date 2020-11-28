FROM node:14-buster-slim

ENV ELM_VERSION 0.19.1

WORKDIR /var/local/app
RUN apt-get -qq update \
  && apt-get -qq -y install curl zip unzip
RUN curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz \
  && gunzip elm.gz \
  && chmod +x elm \
  && mv elm /usr/local/bin/

RUN apt-get -qq update \
  && apt-get -qq -y install curl git openssl make
