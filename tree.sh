#!/bin/bash
n=$SLURM_ARRAY_TASK_ID
module load R/R-4.0.1 
for files in $(ls merged*_$n.csv);
    do echo "$n"; Rscript proj.R $files;
done

