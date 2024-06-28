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
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/step14_jointcall/tables/Table_%j_%a.out

module purge
module load gatk/4.3.0.0

input=/scratch/ajj7988/results/85_samples/step14_jointcall/chr1_joint_H5LGVDRX5_WGS_C_hirsuta.vcf.gz
output=/scratch/ajj7988/results/85_samples/step14_jointcall/tables/chr1_joint_H5LGVDRX5_WGS_C_hirsuta.table 

gatk VariantsToTable \
     -V $input \
     -F CHROM -F QUAL -F QD -F ALT -F DP -F POS -F TYPE -F TRANSITION -F HET \
        -F HOM-REF -F HOM-VAR -F NO-CALL -F NCALLED -F MULTI-ALLELIC \
        -GF AD -GF DP -GF GT -GF PL -GF GQ\
     -O $output
