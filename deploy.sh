#!/usr/bin/env bash

# This script does the entire caboodle of building and pushing the docker image
# For it to work at least web from the docker-compose must be up
# If the image does not require modification then one can simply run:
#   docker-compose exec web cmd deploy staging_web
# OR
#   docker-compose exec web cmd deploy staging_worker

# Exit the script as soon as something fails.
set -e

REPOSITORY=021222724407.dkr.ecr.us-east-1.amazonaws.com/ecs-hello
CLUSTER=ecs-hello
PROFILE=sandbox
BASEDIR=app
PREFIX=ecs-hello

DOCKERFILE="$BASEDIR/Dockerfile"

echo "Deploying using $DOCKERFILE"

IMAGE="$REPOSITORY:latest"
echo "Creating image $IMAGE"
docker image build -t $IMAGE --build-arg DEPLOY=$1  -f $DOCKERFILE .

# eval "$(aws ecr get-login --no-include-email --profile $PROFILE)"
AWS_PROFILE=$PROFILE docker push $IMAGE
aws ecs update-service --cluster $CLUSTER --service $PREFIX --task-definition $PREFIX --desired-count 1 --force-new-deployment --profile $PROFILE

