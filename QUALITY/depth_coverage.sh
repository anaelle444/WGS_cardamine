#!/bin/bash

##SLURM scheduler directives
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=02:00:00
#SBATCH --mem=40GB
#SBATCH --job-name=depthcoverage
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/coverage/slurm_%j_%a.out
#SBATCH --array=86-172

i=${SLURM_ARRAY_TASK_ID}
formID=$(printf '%.3d' "${i}")

input=/scratch/ajj7988/results/85_samples/step10_addRG/RG_added_H5LGVDRX5_WGS_C_hirsuta_${formID}.bam 
output=/scratch/ajj7988/results/85_samples/coverage/coverage_H5LGVDRX5_WGS_C_hirsuta_${formID}_texte.txt

module purge
module load samtools/intel/1.14

#samtools coverage -m ${input} > ${output}
samtools coverage ${input} > ${output}
