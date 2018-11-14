#!/usr/bin/env bash

set -e

PROFILE=sandbox

aws ecs register-task-definition --cli-input-json file://ecs/web-task.json --profile $PROFILE
