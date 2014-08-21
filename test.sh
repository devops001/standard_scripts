#!/bin/bash

AUDIT_LOG=logs/audit.log
DETAIL_LOG=logs/detail.log

. ./error_handling.sh

echo "begin"
fake
echo "end"

