#!/bin/bash
set -e

[ -z "$ROBOT_COMMAND" ] && ROBOT_COMMAND="robot"
[ -z "$ROBOT_FILES" ] && ROBOT_FILES="."

echo "#========! EXECUTING COMMAND $ROBOT_COMMAND $ROBOT_ARGS --outputdir /output/ $ROBOT_FILES !========#"
xvfb-run -a --server-args="-screen 0 $XVFB_RES -ac -nolisten tcp -dpi 96 +extension RANDR" \
$ROBOT_COMMAND $ROBOT_ARGS $ROBOT_ARGS_MASK $SLACK_LISTENER --outputdir /output/ $ROBOT_FILES