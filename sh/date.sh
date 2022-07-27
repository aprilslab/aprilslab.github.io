#!/bin/bash

# echo hello world > b.txt
if [ $# -lt 1 ]; then
  TODAY=$(TZ=KST date -d +"9 hour" +"%Y-%m-%dT%H:%M:%S  %Z %z")
  echo $TODAY
  exit 1
fi

N=$1

# N must be a number.
if [ -n $N ] && [ $N -eq $N ] 2>/dev/null; then
  # OK. It is a number.
  N_DAYS_BEFORE=$(TZ=KST date -d "-$N days +9 hour" "+%Y-%m-%dT%H:%M:%S+09:00 (%Z %z)")
	echo $N_DAYS_BEFORE # For test
else
  echo "N must be a number."
  exit 1
fi

# git push