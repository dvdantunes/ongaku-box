#!/usr/bin/env bash

# Important paths
PROJECT_PATH=$PWD

# Docker configuration
DOCKER_COMPOSE_FILE=docker-compose-production.yml

# Docker images names
DOCKER_IMAGES_PREFIX=demo-tape
APP_IMAGE="$DOCKER_IMAGES_PREFIX-app"
