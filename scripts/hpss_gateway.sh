#!/bin/sh

umask 0002

# start and stop the HPSS gateway

# use new client (5.0.2) (all our servers are 64-bit now)
HPSS_HOME=/opt/local/hpss

BIN_DIR=$(dirname $0)
ACTION=$1
INSTRUMENT=$2

case "$ACTION" in

start)
  $BIN_DIR/watch_hpss $INSTRUMENT
  ;;

stop)
  pkill -f "watch_hpss $INSTRUMENT"
  ;;

restart)
  pkill -f "watch_hpss $INSTRUMENT"
  $BIN_DIR/watch_hpss $INSTRUMENT
  ;;
esac

