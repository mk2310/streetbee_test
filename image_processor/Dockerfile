FROM ruby:2.4.1
ADD . /application
WORKDIR /application
RUN apt update && gem install bundler && bundle install
