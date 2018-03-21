# Internal general purpose utilities for MLSO operations

#### find_noncordyn_files.sh

Script for finding files in a directory hierarchy that are not in the cordyn group or don't have the given (optional) permissions.

    syntax: ./find_noncordyn_files.sh rootdir [r][w][x]

For example, to find files that are not cordyn group in /hao/acos/sw/sbin or are cordyn group, but aren't group readable, do:

    $ VERBOSE=1 ./find_noncordyn_files.sh /hao/acos/sw/sbin r
    /hao/acos/sw/sbin/GetTicket
    /hao/acos/sw/sbin/GetTicket.new
    /hao/acos/sw/sbin/backup-databases.sh
    /hao/acos/sw/sbin/pspt_web
    Searched for files that were not group cordyn or without g+r set


#### fix_noncordyn_files.sh

Script for changing, in a directory hierarchy:

  1. all files to cordyn group with group read/write permissions
  2. all directories to cordyn group with executable permissions

    syntax: ./fix_noncordyn_files.sh rootdir


#### hpss

Script for generating reports of HPSS usage.

    usage: hpss [-h] [-p PREFIX] [-f] [-k] [-s SMALL_FILES_MAX] [root [root ...]]

    HPSS file size utility

    positional arguments:
      root                  HPSS root directory

    optional arguments:
      -h, --help            show this help message and exit
      -p PREFIX, --prefix PREFIX
                            prefix for log files, default is hpss
      -f, --file            set to interpret root as a log file
      -k, --keep-log        set to not delete log file
      -s SMALL_FILES_MAX, --small-files-max SMALL_FILES_MAX
                            warn about files smaller than this size in bytes


#### hpss_gateway.sh

Script to start and stop the `watch_hpss` process to watch a directory for new files to send to the HPSS.

    usage: hpss_gateway.sh action instrument

    positional arguments:
      action      action to perform: start, stop, or restart
      instrument  instrument to watch for: KCor or CoMP

For example, common usage would be to restart the process for an instrument:

    hpss_gateway.sh restart KCor


#### hpss_get.sh

Script to generate an hsi input file for downloading a directory hierarchy in tape order.

    usage: hpss_get.sh hpss_dir [output_file]

    positional arguments:
      hpss_dir      directory to download, i.e., /CORDYN/COMP/2018
      output_file   output file for hsi commands


#### watch_hpss

Script to watch a directory for new files to send to the HPSS. This routine should be started and stopped from `hpss_gateway.sh`.

    usage: watch_hpss [-h] instrument

    Watch for files to send to HPSS

    positional arguments:
      instrument  instrument to watch for: KCor or CoMP

    optional arguments:
      -h, --help  show this help message and exit
