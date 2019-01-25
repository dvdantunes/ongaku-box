FROM ruby:2.5-alpine

LABEL maintainer="David Antunes <dvdantunes@gmail.com>"

RUN apk update && apk add build-base nodejs postgresql-dev tzdata cmake git vim

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME

RUN bundle install --binstubs

COPY . .

CMD puma -C config/puma.rb
