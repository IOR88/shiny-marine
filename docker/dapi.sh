#!/usr/bin/env bash


#set -ex

DOCKER_COMPOSE_BASE_FILE="docker-compose.yml"

ENV=.env.dev
set -o allexport
source $ENV
set +o allexport
export ENV
pwd

DOCKER_INSTRUCTION=$@
docker-compose --file $DOCKER_COMPOSE_BASE_FILE $DOCKER_INSTRUCTION