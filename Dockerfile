FROM ruby:2.5-alpine

RUN apk update && apk add build-base nodejs postgresql-dev cmake git vim

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs

COPY . .

LABEL maintainer="David Antunes <dvdantunes@gmail.com>"

CMD puma -C config/puma.rb
