#!/usr/bin/env bash

START=$(date +%s)
rsync -rptzhvv /var/cache/pacman/pkg/*.xz . --progress --log-file=../$HOSTNAME-repo-backup.log
FINISH=$(date +%s)
echo "total time: $(( ($FINISH-$START) / 60 )) minutes, $(( ($FINISH-$START) % 60 )) seconds"

touch ../"Backup from $(date '+%A, %d %B %Y, %T')"
