#!/bin/bash
set -e
cd /$TESTDIR
if [ "$THREADS" -eq 0 ]; then
echo "#========! EXECUTING COMMAND robot $ROBOTARGS --outputdir /outputs/ $ROBOT_FILES !========#"
xvfb-run -a --server-args="-screen 0 $XVFB_RES -ac -nolisten tcp -dpi 96 +extension RANDR" \
        robot $ROBOTARGS --outputdir /outputs/ $ROBOT_FILES
else
echo "#========! EXECUTING COMMAND pabot $ROBOTARGS --outputdir /outputs/ $ROBOT_FILES !========#"
xvfb-run -a --server-args="-screen 0 $XVFB_RES -ac -nolisten tcp -dpi 96 +extension RANDR" \
        pabot $ROBOTARGS --outputdir /outputs/ $ROBOT_FILES
fi