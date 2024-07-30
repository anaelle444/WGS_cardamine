#!/bin/bash

##SLURM scheduler directives
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --mem=200GB
#SBATCH --job-name=TableIndex
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/ALLELEFREQ/_%j_%a.out

#i=${SLURM_ARRAY_TASK_ID}

module purge
module load gatk/4.3.0.0
module load bcftools/intel/1.19
module load jdk/11.0.9

input=/scratch/ajj7988/results/85_samples/verification/cond4/ATH_allCHROM_r2.vcf.gz
output=/scratch/ajj7988/results/85_samples/allele_frequencies.txt


bcftools query -f '%CHROM\t%POS\t%AF\n' ${input} > ${output}
