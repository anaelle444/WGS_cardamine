#!/bin/bash

##SLURM scheduler directives
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --mem=200GB
#SBATCH --job-name=Table
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/tues25/Table_%j_%a.out
#SBATCH --array=1-8

i=${SLURM_ARRAY_TASK_ID}

module purge
module load gatk/4.3.0.0

input=/scratch/ajj7988/results/chr${i}_select_variants.vcf.gz 
output=/scratch/ajj7988/results/chr${i}_mix_filtered.table 

gatk VariantsToTable \
     -V $input \
     -F CHROM -F QUAL -F ALT -F DP -F POS -F TYPE -F TRANSITION -F HET \
        -F HOM-REF -F HOM-VAR -F NO-CALL -F NCALLED -F MULTI-ALLELIC \
        -GF AD -GF DP -GF GT -GF PL -GF GQ\
     -O $output
