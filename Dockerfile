# Dockerfile
#
# @see https://docs.docker.com/compose/reference/run/
# @see https://github.com/ledermann/docker-rails

FROM ruby:2.5-alpine
LABEL maintainer="David Antunes <dvdantunes@gmail.com>"

# Get build args
ARG ADDITIONAL_PACKAGES

# Setting environment vars
ENV APP_HOME /app
ENV APP_USER app


# Add Alpine packages
RUN apk update \
  && apk add --update --no-cache \
    build-base \
    shadow \
    sudo \
    cmake \
    bash \
    vim \
    git \
    curl \
    python2 \
    nodejs-current \
    yarn \
    sqlite-dev \
    postgresql-dev \
    postgresql-client \
    imagemagick \
    tzdata \
    $ADDITIONAL_PACKAGES

# Activate wheel group to allow sudoers
RUN set -o pipefail && echo '%wheel ALL=(ALL) NOPASSWD: ALL' | tee -a /etc/sudoers

# Add '$APP_USER' user, add it to sudoers wheel group
RUN addgroup -g 1000 -S $APP_USER \
 && adduser -u 1000 -S $APP_USER -G $APP_USER -s /bin/bash \
 && usermod -aG wheel $APP_USER

# Create app home directory and set it as current directory
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Copy app files
COPY . .

# Install dependencies
RUN yarn install
RUN bin/bundle install
#RUN bin/bundle exec rake assets:precompile


# Copy root shell configuration
COPY env/.profile "/root/.profile"
COPY env/.bashrc "/root/.bashrc"

# Copy '$APP_USER' user shell configuration
COPY --chown=app:app env/.profile "/home/$APP_USER/.profile"
COPY --chown=app:app env/.bashrc "/home/$APP_USER/.bashrc"


# Expose Puma port
EXPOSE 3000


# Set entrypoint
ENTRYPOINT ["/app/docker/entrypoint"]
