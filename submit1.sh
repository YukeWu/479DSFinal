#!/bin/bash
#module load R/R-3.6.1
rm -rf slurm_out
mkdir -p slurm_out
# echo "Hello, std from submit.sh."
echo "1"
jobId1=$(sbatch --output="slurm_out/slurm-%A_%a.out" \
                preCleanUpMakeDirs.sh)
jobId1=$(echo $jobId1 | sed 's/Submitted batch job //')

echo "2"
jobId2=$(sbatch --array=1-12 \
                --output="slurm_out/slurm-%A_%a.out" \
                --dependency=afterany:$jobId1 \
                get09Data.sh)
jobId2=$(echo $jobId2 | sed 's/Submitted batch job //')

echo "3"
jobId3=$(sbatch --array=1-1 \
                --output="slurm_out/slurm-%A_%a.out" \
                --dependency=afterany:$jobId2 \
                getQ1.sh)
jobId3=$(echo $jobId3 | sed 's/Submitted batch job //')
