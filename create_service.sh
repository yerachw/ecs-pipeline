#!/usr/bin/env bash

set -e

PROFILE=sandbox

aws ecs create-service --cli-input-json file://ecs/web-service.json --profile $PROFILE
