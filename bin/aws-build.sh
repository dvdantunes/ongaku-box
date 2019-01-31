#!/usr/bin/env bash

BIN_PATH="$PWD/bin"


# Load env configuration
source "$BIN_PATH/env-configuration.sh"

# Load utils
source "$BIN_PATH/utilities.sh"

# Load AWS configuration
source "$BIN_PATH/aws-config.sh"



# Build project

# Build docker images
# Note: we need to do this because AWS ECS doesn't allow builds by docker-compose.yml files
# so we need to do local build and push them through ECR
colorecho "Building docker images" $YELLOW

docker build -t $APP_IMAGE:latest $PROJECT_PATH
dekita
breakline



# Amazon ECR docker image push

# Get AWS auth token
colorecho "Getting AWS auth token" $YELLOW
eval $(aws ecr get-login --no-include-email --region $AWS_DEFAULT_REGION)
dekita
breakline


# Check if repository exist for each image and push each image
colorecho "Pushing images to Amazon ECR" $YELLOW

DOCKER_IMAGES=($APP_IMAGE)

for IMAGE in "${DOCKER_IMAGES[@]}"
do
    breakline

    colorecho "Pushing '$IMAGE' image" $YELLOW
    breakline

    aws ecr list-images --repository-name $IMAGE &> /dev/null

    last_command_code=$?
    if [ $last_command_code -eq 0 ];then
       echo "'$IMAGE' repository found"

    else
       echo "'$IMAGE' repository not found, creating repository"
       (aws ecr create-repository --repository-name $IMAGE) || true
    fi

    # eg: 223263753891.dkr.ecr.us-east-1.amazonaws.com/demo-tape-app:latest
    docker tag $IMAGE:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE:latest
    docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE:latest

    last_command_code=$?
    if [ $last_command_code -ne 0 ];then
        colorecho "Error found pushing '$IMAGE' image" $RED
        breakline
        exit 1
    fi
done
breakline
dekita
