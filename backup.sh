#!/bin/bash
# Purpose:     Performs incremental backups of a given directory.
# Author:      Ryan McDonald  <devops001@gmail.com>
#######################################################################

DIR_TO_BKP=$1
BKP_DIR=$HOME/bkp   #<- where bkp will be created 

#######################################################################
## validate parms:
#######################################################################

function usage {
  echo "USAGE:"
  echo "   $0 /absolute/path/to/some/dir/to/backup"
  exit 1
}

if [[ -z $DIR_TO_BKP ]]; then
  echo "Missing DIR_TO_BKP (the only parm)"
  usage
fi

if [[ ! -d $DIR_TO_BKP ]]; then
  echo "$DIR_TO_BKP does not exist!"
  usage
fi

if [[ ! -d $BKP_DIR ]]; then
  mkdir -p $BKP_DIR
  if [[ ! -d $BKP_DIR ]]; then
    echo "Unable to create BKP_DIR: $BKP_DIR"
    exit 1
  fi
fi

#######################################################################
## setup variables:
#######################################################################

DATA_DIRNAME=$(dirname $DIR_TO_BKP)
DATA_BASENAME=$(basename $DIR_TO_BKP)

STAMP=$(date +"%Y%m%d.%H%M%S") 
DOW=$(date +"%a")

BKP_FILE=$BKP_DIR/${STAMP}_${DATA_BASENAME}_inc_bkp.$DOW.tgz     
INC_FILE=$BKP_DIR/1_${DATA_BASENAME}.snar

#######################################################################
## create backup:
#######################################################################

# so the file paths in the tar start with the $DATA_DIR directory:
cd $DATA_DIRNAME

# create backup:
tar -g $INC_FILE -cpzf $BKP_FILE $DATA_BASENAME

# list files in backup:
echo "Backed up the following files to $BKP_DIR:"
tar -tzf $BKP_FILE

