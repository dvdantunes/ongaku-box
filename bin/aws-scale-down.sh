#!/usr/bin/env bash

BIN_PATH="$PWD/bin"


# Load env configuration
source "$BIN_PATH/env-configuration.sh"

# Load utils
source "$BIN_PATH/utilities.sh"

# Load AWS configuration
source "$BIN_PATH/aws-config.sh"




# Amazon ECS cluster scale down

colorecho "Scaling down '$AWS_ECS_CLUSTER_NAME' cluster on Amazon ECS" $YELLOW
breakline

ecs-cli compose \
  --verbose \
  --project-name $AWS_ECS_PROJECT_NAME \
  --file $DOCKER_COMPOSE_FILE \
  --ecs-params $AWS_ECS_PARAMS_FILE \
  service down \
  --cluster-config $AWS_ECS_CLUSTER_CONFIG

breakline
dekita
