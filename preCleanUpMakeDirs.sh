#!/bin/bash
#find . -type f -name '*.bz2' -delete
find . -type f -name '*.csv' -delete
find . -type f -name '*.zip' -delete
rm -rf slurm_out

echo "Hello from preCleanUpMakeDirs.sh"
