#!/bin/sh

PYTHON=/home/mgalloy/anaconda3/bin/python

# need both action and instrument arguments to work
if [ $# -lt 3 ]; then
  echo "usage: $(basename $0) action instrument"
  echo
  echo "positional arguments:"
  echo "  action      action to perform: start, stop, or restart"
  echo "  method      method, e.g., hpss, local, globus"
  echo "  instrument  instrument to watch for, e.g., kcor, comp, ucomp, etc."
  exit 1
fi

umask 0002

# start and stop the HPSS gateway

BIN_DIR=$(dirname $0)
ACTION=$1
METHOD=$2
INSTRUMENT=$3


kill_instrument () {
  pkill -f "mlso-archiverd --method $1 $2"
}

start_instrument () {
  $PYTHON $BIN_DIR/mlso-archiverd --method $1 $2
}

case "$ACTION" in
  start)
    start_instrument $METHOD $INSTRUMENT
    ;;

  stop)
    kill_instrument $METHOD $INSTRUMENT
    ;;
  restart)
    kill_instrument $METHOD $INSTRUMENT
    start_instrument $METHOD $INSTRUMENT
    ;;
esac

