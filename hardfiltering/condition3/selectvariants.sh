#!/bin/bash

#SBATCH --time=04:00:00
#SBATCH --mem=40GB
#SBATCH --tasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --job-name=selectcond3
#SBATCH --error=/scratch/ajj7988/log/week4/85samples/verification/condition3/select_p2_%A.err
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/verification/condition3/select_p2_%A.out
#SBATCH --array=1-8

i=${SLURM_ARRAY_TASK_ID}

module load jdk/11.0.9                                                                                                                                         
module load gatk/4.3.0.0 
module load samtools/intel/1.14
module load bcftools/intel/1.14

ref=/scratch/ajj7988/data/cardamina_fastq/CHIR.fasta

#input=/scratch/ajj7988/results/85_samples/step14_jointcall/chr${i}_joint_H5LGVDRX5_WGS_C_hirsuta.vcf.gz
intermediate=/scratch/ajj7988/results/85_samples/verification/cond3/chr${i}_onlycalled_filter_H5LGVDRX5_WGS_C_hirsuta.vcf.gz
output=/scratch/ajj7988/results/85_samples/verification/cond3/chr${i}_onlycalled_selected_H5LGVDRX5_WGS_C_hirsuta.vcf.gz

#echo "INVCF:         ${INVCF}"
#echo "FVCF:          ${FVCF}"
#echo "OUTVCF:        ${OUTVCF}"

chmod +x ${intermediate}

gatk --java-options "-Xmx14g -Xms14g" SelectVariants \
	-R ${ref} \
	-V ${intermediate} \
	-O ${output} \
	--set-filtered-gt-to-nocall

