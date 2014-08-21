#!/bin/bash
# Purpose:    Source this file to handle all of your scripting errors in a standard way.
# Author:     Ryan McDonald <devops001@gmail.com>
# Note:       To use logging (recommended!), set the log file paths in the following two
#             variables BEFORE sourcing this script. 
#             simple example:
#               AUDIT_LOG=./audit.log
#               DETAIL_LOG=./detail.log
#               . ./error_handling.sh
#####################################################################################################

# To report the errors via HP's OpenView, just make sure that the following path is correct 
OPENVIEW_CMD=/usr/lpp/OV/OpC/opcmsg

report_error() {
  STAMP=$(date '+%Y%m%d.%H%M.%S')
  APP=$(basename $0)
  GRP=$(whoami)
	OBJ=abend
	SEV=critical
  MSG="$STAMP | $APP | abended on line number $1 (runtime user: $GRP)"

  # attempt to send an alert to ops via HP's OpenView:
  if [[ -n $OPENVIEW_CMD && -x $OPENVIEW_CMD ]]; then
	  $OPENVIEW_CMD sev="$SEV" application="$APP" msg_grp="$GRP" object="$OBJ" msg_text="$MSG"
  fi

  # attempt to log to the standard DETAIL_LOG:
  if [[ -n $DETAIL_LOG ]]; then
    echo "$MSG" >> $DETAIL_LOG
  fi

  # attempt to log to the standard AUDIT_LOG:
  if [[ -n $AUDIT_LOG ]]; then
    echo "$MSG" >> $AUDIT_LOG
  fi
  
  echo "$MSG"
}

# catch & send all errors through the above report_error() function:
trap 'report_error $LINENO' ERR

# stop executing on an error:
set -e

# if using a standard DETAIL_LOG, then append all stderr messages to it while also printing them to stdout:
if [[ -n $DETAIL_LOG ]]; then
  exec 2> >(tee -a $DETAIL_LOG)
  STAMP=$(date '+%Y%m%d.%H%M.%S')
  SCRIPT=$(basename $0)
  echo "$STAMP | $SCRIPT | error_handling.sh was called." >> $DETAIL_LOG
else
  echo "Warning: error_handling.sh was sourced without logging setup so no logs will be used!"
fi

