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
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/verification/condition4/Table_et_index_%j_%a.out
#SBATCH --array=1-8

i=${SLURM_ARRAY_TASK_ID}

module purge
module load gatk/4.3.0.0
module load bcftools/intel/1.19
module load jdk/11.0.9

#input=/scratch/ajj7988/results/85_samples/verification/cond4/chr${i}_allfiltered_selected_H5LGVDRX5_WGS_C_hirsuta.vcf.gz
intermediate=/scratch/ajj7988/results/85_samples/verification/cond4/chr${i}_allfiltered_intermediate_H5LGVDRX5_WGS_C_hirsuta.vcf.gz
output=/scratch/ajj7988/results/85_samples/verification/cond4/chr${i}_allfiltered_selected_H5LGVDRX5_WGS_C_hirsuta.table

#bcftools +fill-tags -Ov -o ${intermediate} ${input} -- -t all

#chmod +x ${intermediate}

tabix ${intermediate}

gatk VariantsToTable \
        -V ${intermediate} \
        -F CHROM -F POS -F TYPE -F AC -F QUAL \
        -F AF -F AN -F DP -F BaseQRankSum \
        -F ExcessHe -F FS -F InbreedingCoeff -F MLEAC \
        -F MLEAF -F MQ -F MQRankSum -F ReadPosRankSum \
        -F SOR -F EVENTLENGTH -F HET -F HOM-REF -F HOM-VAR \
        -F NO_CALL -F VAR -F NSAMPLES -F NCALLED \
        -F MULTI-ALLELIC -F QD \
        -O ${output}

