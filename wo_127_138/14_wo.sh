#!/bin/bash

##SLURM scheduler directives
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=04:00:00
#SBATCH --mem=65GB
#SBATCH --job-name=joint_call
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week6/jointcall/joint_call_%j_%a.out
#SBATCH --array=1-8

i=${SLURM_ARRAY_TASK_ID}

module purge
module load gatk/4.3.0.0

ref=/scratch/ajj7988/data/cardamina_fastq/CHIR.fasta
database=/scratch/ajj7988/results/85_samples/wo_127_138/DBImport/DB_chr$i
output=/scratch/ajj7988/results/85_samples/wo_127_138/jointcall/chr${i}_joint_H5LGVDRX5_WGS_C_hirsuta.vcf.gz

gatk --java-options "-Xmx60g -Xmx60g" GenotypeGVCFs \
     -R $ref \
     -V gendb://$database \
     -O $output
