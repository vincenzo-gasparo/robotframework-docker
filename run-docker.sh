#!/usr/bin/env bash
VERSION="latest"
ROBOT_FILES="."
ROBOT_ARGS=
ROBOT_ARGS_MASK=
ROBOT_COMMAND="robot"
docker run --rm \
           -v $PWD/atests:/robot \
           -v $PWD/output:/outputs \
           blastoiseomg/robotframework-docker:$VERSION