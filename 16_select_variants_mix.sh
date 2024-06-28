#!/bin/bash


##SLURM scheduler directives
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --mem=20GB
#SBATCH --job-name=selectvariant
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/step16_selectvariants/select_variants_%j_%a.out
#SBATCH --array=1-8

i=${SLURM_ARRAY_TASK_ID}

module purge
module load gatk/4.3.0.0

ref=/scratch/ajj7988/data/cardamina_fastq/CHIR.fasta

input=/scratch/ajj7988/results/85_samples/step15_variantfiltration/chr${i}_filtered.vcf.gz
output=/scratch/ajj7988/results/85_samples/step16_selectvariants/chr${i}_selected_variants.vcf.gz

gatk SelectVariants \
	-R $ref \
	-V $input \
	-O $output \
	--exclude-filtered true

#gatk SelectVariants \
#        -R $ref \
#        -V $inputSNP \
#        -O $outputSNP \
#        --select-type-to-include SNP \
#        --exclude-filtered true

#gatk SelectVariants \
#        -R $ref \
#        -V $inputINDEL \
#        -O $outputINDEL \
#        --select-type-to-include INDEL \
#        --exclude-filtered true
