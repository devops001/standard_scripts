#!/bin/bash
# Purpose:   Restores incremental backups of a given directory.
# Author:    Ryan McDonald <devops001@gmail.com>
#######################################################################

DIR_TO_RESTORE=$1
BKP_DIR=$HOME/bkp   #<- where incremental backups exist

#######################################################################
## validate parms:
#######################################################################

function usage {
  echo "USAGE:"
  echo "   $0 relative_dir_to_be_restored"
  echo
  echo "Note: the dir to restore must resemble files in:"
  echo "      $BKP_DIR"
  exit 1
}

if [[ -z $DIR_TO_RESTORE ]]; then
  echo "Missing DIR_TO_RESTORE (the only parm)"
  usage
fi

WILDCARD="$BKP_DIR/*$DIR_TO_RESTORE*tgz"
BKP_COUNT=$(ls $WILDCARD 2>/dev/null | wc -l)

if [[ $BKP_COUNT < 1 ]]; then
  echo "Couldn't find any bkp files with:"
  echo "ls $WILDCARD"
  usage
fi

#######################################################################
## setup variables:
#######################################################################

STAMP=$(date +"%Y%m%d.%H%M%S") 
RESTORE_DIR=${DIR_TO_RESTORE}_restored_$STAMP

#######################################################################
## create backup:
#######################################################################

mkdir $RESTORE_DIR
cd    $RESTORE_DIR

for TGZ in $(ls $WILDCARD); do
  tar -z --extract --listed-incremental=/dev/null --file $TGZ
done

cd ..
echo "$DIR_TO_RESTORE has been restored to:"
echo
echo "./$(ls -d $RESTORE_DIR/$DIR_TO_RESTORE)"
echo

