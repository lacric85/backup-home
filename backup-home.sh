#!/bin/sh
## Backup needed files and folders from user's home directory.


## Target directory where the backup file will be created:
BACKUPDIR="/media/my_passport/archives/homebackups"

## From file containing the names of directories to back up:
DIRLIST=`cat backup_dirs.txt`
## From file containing the names of files to back up:
FILELIST=`cat backup_files.txt`

## Create filename for backup file:
NAME="home-backup"
SEP="--"
DATE=`date +%Y-%m-%d--%H%M`
## Full filename (without filename extension):
FILENAME=`echo $NAME$SEP$DATE`

## Create the actual archive with verbose output saved to a log file:
XZ_OPT=-9 tar -C $HOME -cvhJf $BACKUPDIR/$FILENAME.tar.xz $DIRLIST $FILELIST 2>&1 | \
   tee $BACKUPDIR/$FILENAME.log

## Create another file containing only tar warnings/errors from log:
cat $BACKUPDIR/$FILENAME.log | grep tar: > $BACKUPDIR/$FILENAME-tar.log

exit 0
