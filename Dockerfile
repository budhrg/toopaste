FROM ubuntu:14.04
MAINTAINER rutuja.khandpekar@vertisinfotech.com

RUN apt-get update -q ; apt-get install -y build-essential ruby1.9.3 ruby1.9.1-dev rake libsqlite3-dev libmysqlclient-dev
RUN apt-get install make
RUN mkdir home/toopaste
ADD . home/toopaste
WORKDIR home/toopaste
RUN gem install bundler
RUN bundle
