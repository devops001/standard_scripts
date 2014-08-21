#!/bin/bash

###########################################################################
## 1. set the two standard log variables first if you want to use logging:
###########################################################################

AUDIT_LOG=logs/audit.log
DETAIL_LOG=logs/detail.log

###########################################################################
## 2. enable error handling (catches & reports any error, then abends):
###########################################################################

. ./error_handling.sh

echo "begin"

###########################################################################
## 3. disable error handling to handle it yourself: (keeps running after errors):
###########################################################################

. ./rm_error_handling.sh

CMD=fake1
$CMD
RC=$?

if [[ $RC -ne 0 ]]; then
  echo "$CMD command failed. it returned: $RC"
fi

###########################################################################
## 4. enable error handling again: 
###########################################################################

. ./error_handling.sh
fake2

###########################################################################
## 5. execution should never reach this far if error handling is enabled.
###########################################################################

fake3
echo "end"

