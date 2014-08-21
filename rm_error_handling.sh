#!/bin/bash
# Purpose:   Disables the error handling features set by sourcing error_handling.sh
# Author:    Ryan McDonald <devops001@gmail.com>
########################################################################

# do not catch errors:
trap  " " ERR

# continue on error:
set +e

# redirect the stderr file descriptor back to stderr:
exec 2> /dev/stderr

if [[ -n $DETAIL_LOG ]]; then
  STAMP=$(date '+%Y%m%d.%H%M.%S')
  SCRIPT=$(basename $0)
  echo "$STAMP | $SCRIPT | rm_error_handling.sh was called." >> $DETAIL_LOG
fi

