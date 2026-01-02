#!/bin/bash

REPO_DIR=/home/ubuntu/devops-assignment
LOG_FILE=$REPO_DIR/cron_cleanup.log
SIZE_LIMIT=50M

cd $REPO_DIR || exit 1

echo "----- CRON RUN $(date) -----" >> $LOG_FILE

# Find files larger than 50MB
LARGE_FILES=$(find . -type f -size +$SIZE_LIMIT ! -path "./.git/*")

if [ -n "$LARGE_FILES" ]; then
  echo "Large files detected:" >> $LOG_FILE
  echo "$LARGE_FILES" >> $LOG_FILE

  # Remove large files from git tracking
  for file in $LARGE_FILES; do
    git rm --cached "$file" 2>/dev/null
  done

  git commit -m "CRON: Removed large files automatically" >> $LOG_FILE
else
  echo "No large files found" >> $LOG_FILE
fi

# Commit files less than 50MB
git add .
git commit -m "CRON: Auto commit small files" >> $LOG_FILE
