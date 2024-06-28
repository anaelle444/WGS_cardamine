#!/bin/bash

##SLURM scheduler directives
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --mem=20GB
#SBATCH --job-name=filter
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/step15_hardfilter/filter_%j_%a.out
#SBATCH --array=1-8

i=${SLURM_ARRAY_TASK_ID}

module purge
module load gatk/4.3.0.0

ref=/scratch/ajj7988/data/cardamina_fastq/CHIR.fasta
input=/scratch/ajj7988/results/85_samples/step14_jointcall/chr${i}_joint_H5LGVDRX5_WGS_C_hirsuta.vcf.gz
output=/scratch/ajj7988/results/85_samples/step15_variantfiltration/chr${i}_filtered_H5LGVDRX5_WGS_C_hirsuta.vcf.gz

gatk VariantFiltration \
	-R $ref \
	-V $input \
	-O $output \
	-filter "QD < 2.0" --filter-name "QD2" \
	-filter "MQ < 50.0" --filter-name "MQ50" \
	-filter "SOR > 3.0" --filter-name "SOR3" \
	-filter "QUAL < 30.0" --filter-name "QUAL30" \

#gatk VariantFiltration \
#    -V $input \
#    -filter "QD < 2.0" --filter-name "QD2" \
#    -filter "QUAL < 30.0" --filter-name "QUAL30" \
#    -filter "SOR > 3.0" --filter-name "SOR3" \
#    -filter "FS > 60.0" --filter-name "FS60" \
#    -filter "MQ < 40.0" --filter-name "MQ40" \
#    -filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
#    -filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
#    -O $outputSNP

#gatk VariantFiltration \
#    -V $input \
#    -filter "QD < 2.0" --filter-name "QD2" \
#    -filter "QUAL < 30.0" --filter-name "QUAL30" \
#    -filter "FS > 200.0" --filter-name "FS200" \
#    -filter "ReadPosRankSum < -20.0" --filter-name "ReadPosRankSum-20" \
#    -O $outputINDEL
