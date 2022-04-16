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
jobId3=$(sbatch --array=1-12 \
                --output="slurm_out/slurm-%A_%a.out" \
                --dependency=afterany:$jobId2 \
                get10Data.sh)
jobId3=$(echo $jobId3 | sed 's/Submitted batch job //')

echo "4"
jobId4=$(sbatch --array=1-12 \
                --output="slurm_out/slurm-%A_%a.out" \
                --dependency=afterany:$jobId3 \
                get11Data.sh)
jobId4=$(echo $jobId4 | sed 's/Submitted batch job //')

echo "5"
jobId5=$(sbatch --array=1-12 \
		--output="slurm_out/slurm-%A_%a.out" \
		--dependency=afterany:$jobId4 \
                get12Data.sh)
jobId5=$(echo $jobId5 | sed 's/Submitted batch job //')
