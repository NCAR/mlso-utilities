#!/bin/sh

# need both action and instrument arguments to work
if [ $# -lt 2 ]; then
  echo "usage: $(basename $0) action instrument"
  echo
  echo "positional arguments:"
  echo "  action      action to perform: start, stop, or restart"
  echo "  instrument  instrument to watch for: KCor or CoMP"
  exit 1
fi

umask 0002

# start and stop the HPSS gateway

# use new client (5.0.2) (all our servers are 64-bit now)
HPSS_HOME=/opt/local/hpss

BIN_DIR=$(dirname $0)
ACTION=$1
INSTRUMENT=$2


kill_instrument () {
  pkill -f "watch_hpss $1"
}

start_instrument () {
  $BIN_DIR/watch_hpss $1
}

case "$ACTION" in

start)
  start_instrument $INSTRUMENT
  ;;

stop)
  kill_instrument $INSTRUMENT
  ;;

restart)
  kill_instrument $INSTRUMENT
  start_instrument $INSTRUMENT
  ;;
esac

