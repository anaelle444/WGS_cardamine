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
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/verification/condition1/Table_%j_%a.out
#SBATCH --array=1-8

i=${SLURM_ARRAY_TASK_ID}

module purge
module load gatk/4.3.0.0

input=/scratch/ajj7988/results/85_samples/step14_jointcall/chr${i}_joint_H5LGVDRX5_WGS_C_hirsuta.vcf.gz 
output=/scratch/ajj7988/results/85_samples/verification/cond1/chr${i}_no_filter_H5LGVDRX5_WGS_C_hirsuta.table 

gatk VariantsToTable \
        -V ${input} \
        -F CHROM -F POS -F TYPE -F AC -F QUAL \
        -F AF -F AN -F DP -F BaseQRankSum \
        -F ExcessHe -F FS -F InbreedingCoeff -F MLEAC \
        -F MLEAF -F MQ -F MQRankSum -F ReadPosRankSum \
        -F SOR -F EVENTLENGTH -F HET -F HOM-REF -F HOM-VAR \
        -F NO_CALL -F VAR -F NSAMPLES -F NCALLED \
        -F MULTI-ALLELIC -F QD \
        -O ${output}


echo "script17"
