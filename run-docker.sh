#!/usr/bin/env bash
VERSION="latest"
ROBOT_FILES=
HOST_TESTDIR="atests"
TESTDIR=$(basename $HOST_TESTDIR)
ARGS="--console-verbose"
THREADS="0"
docker run --rm \
           -v $PWD/$HOST_TESTDIR:/$TESTDIR/ \
           -v $PWD/output:/outputs \
           -e ROBOTARGS="$ARGS" \
           -e THREADS="$THREADS" \
           -e ROBOT_FILES="$ROBOT_FILES" \
           -e TESTDIR="$TESTDIR" \
           blastoiseomg/robotframework-docker:$VERSION