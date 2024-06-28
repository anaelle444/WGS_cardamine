#!/bin/bash

##SLURM scheduler directives
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12
#SBATCH --time=01:00:00
#SBATCH --mem=10GB
#SBATCH --job-name=%a_@RG
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/step10_RG/@RG_%j_%a.out
#SBATCH --array=86-172

i=${SLURM_ARRAY_TASK_ID}
formID=$(printf '%.3d' "${i}")

module purge
module load picard/2.27.5

PICARD=/share/apps/picard/2.27.5/picard.jar

input=/scratch/ajj7988/results/85_samples/step09_removedup/removed_dup_H5LGVDRX5_WGS_C_hirsuta_${formID}.bam
output=/scratch/ajj7988/results/85_samples/step10_addRG/RG_added_H5LGVDRX5_WGS_C_hirsuta_${formID}.bam

java -Xmx10g -Xms10g -jar $PICARD AddOrReplaceReadGroups \
      I=$input \
      O=$output \
      RGID=A01097_H5LGVDRX5_1 \
      RGLB=WGS_C_hirsuta_${formID} \
      RGPL=ILLUMINA \
      RGPU=H5LGVDRX5\
      RGSM=WGS_C_hirsuta_${formID}
