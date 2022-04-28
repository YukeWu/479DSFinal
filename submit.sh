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

echo "6"
jobId6=$(sbatch --array=1-4 \
		--output="slurm_out/slurm-%A_%a.out" \
		--dependency=afterany:$jobId5 \
                getQ1.sh)
jobId6=$(echo $jobId6 | sed 's/Submitted batch job //')

echo "7"
jobId7=$(sbatch --array=1-4 \
		--output="slurm_out/slurm-%A_%a.out" \
		--dependency=afterany:$jobId6 \
                getQ2.sh)
jobId7=$(echo $jobId7 | sed 's/Submitted batch job //')

echo "8"
jobId8=$(sbatch --array=1-4 \
		--output="slurm_out/slurm-%A_%a.out" \
		--dependency=afterany:$jobId7 \
                getQ3.sh)
jobId8=$(echo $jobId8 | sed 's/Submitted batch job //')

echo "9"
jobId9=$(sbatch --array=1-4 \
		--output="slurm_out/slurm-%A_%a.out" \
		--dependency=afterany:$jobId8 \
                getQ4.sh)
jobId9=$(echo $jobId9 | sed 's/Submitted batch job //')

echo "build tree"
jobId10=$(sbatch --array=2009-2012 \
                --mem=15G \
	        --output="slurm_out/slurm-%A_%a.out" \
                --error="slurm_out/slurm-%A_%a.err" \
		--dependency=afterok:$jobId9 \
		tree.sh)

jobId10=$(echo $jobId10 | sed 's/Submitted batch job //')
