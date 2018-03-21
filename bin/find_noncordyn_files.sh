#!/bin/sh

if [[ ($# -lt 1) || ($# -gt 2) ]]; then
  echo "syntax: $0 rootdir [r][w][x]"
  exit 1
fi

OPTIONS=$2

READABLE="-or ! -perm -g+r"
WRITABLE="-or ! -perm -g+w"
EXECUTABLE="-or ! -perm -g+x"

OPTIONS_CMD=

if echo $OPTIONS | grep r > /dev/null; then
  OPTIONS_CMD="$OPTIONS_CMD $READABLE"
  OPTIONS_DESC="or without g+r set"
fi

if echo $OPTIONS | grep w > /dev/null; then
  OPTIONS_CMD="$OPTIONS_CMD $WRITABLE"
  OPTIONS_DESC="or without g+w set"
fi

if echo $OPTIONS | grep x > /dev/null; then
  OPTIONS_CMD="$OPTIONS_CMD $EXECUTABLE"
  OPTIONS_DESC="or without g+x set"
fi

# check readable if no other option set
if [ -z "$OPTIONS_CMD" ]; then
  OPTIONS_CMD="$OPTIONS_CMD $READABLE"
  OPTIONS_DESC="or without g+r set"
fi

CMD="find $1 ! -group cordyn $OPTIONS_CMD"
$CMD

if [ $VERBOSE ]; then
  if [[ "$VERBOSE" == 1 ]]; then
    echo "Searched for files that were not group cordyn $OPTIONS_DESC"
  fi
fi