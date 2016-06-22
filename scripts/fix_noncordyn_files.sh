#!/bin/sh

if [[ ($# -lt 1) || ($# -gt 1) ]]; then
  echo "syntax: $0 rootdir"
  exit 1
fi

ROOT_DIR=$1

# find non-cordyn files
find $ROOT_DIR ! -group cordyn -exec sh -c "echo Changing ownership of {}; chown :cordyn {}" \;

# find non group-readable files
find $ROOT_DIR ! -perm -g+r -exec sh -c "echo Making {} group readable; chmod g+r {}" \;

# find non group-writeable files
find $ROOT_DIR ! -perm -g+w -exec sh -c "echo Making {} group writeable; chmod g+w {}" \;

# find directories which are not group executable
find $ROOT_DIR ! -perm -g+x -and -type d -exec sh -c "echo Making directory {} executable; chmod g+x {}" \;
