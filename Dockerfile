# xinTest
#
# VERSION               0.0.1

FROM ruby:2.0

MAINTAINER xiaozi0lei <xiaozi0lei@163.com>

LABEL Description="This image is used to test the web app interface" Version="1.0"

ENV XINTEST_HOME /usr/local/xinTest
RUN mkdir -p "$XINTEST_HOME" \
      && apt-get update && apt-get install -y vim postgresql-client

WORKDIR $XINTEST_HOME
COPY . $XINTEST_HOME

RUN bundle install

EXPOSE 3000

CMD rails s
