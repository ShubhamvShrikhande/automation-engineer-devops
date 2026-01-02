#!/bin/bash

BASE_DIR="$HOME/devops-assignment/bash/files"
LOG_FILE="$HOME/devops-assignment/bash/large_files.log"

echo "Creating files directory..."
mkdir -p $BASE_DIR
cd $BASE_DIR || exit 1

echo "Creating files..."

# 10 x 50MB
for i in {1..10}; do
  fallocate -l 50M file_50MB_$i
done

# 20 x 100MB
for i in {1..20}; do
  fallocate -l 100M file_100MB_$i
done

# 30 x 500MB
for i in {1..30}; do
  fallocate -l 500M file_500MB_$i
done

# 5 x 1GB
for i in {1..5}; do
  fallocate -l 1G file_1GB_$i
done

# 3 x 5GB
for i in {1..3}; do
  fallocate -l 5G file_5GB_$i
done

# 1 x 10GB
fallocate -l 10G file_10GB_1

echo "Finding files larger than 50MB..."
find . -type f -size +50M -exec du -h {} + | sort -hr > $LOG_FILE

echo "Large files sorted (saved in large_files.log)"
