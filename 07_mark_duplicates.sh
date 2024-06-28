#!/bin/bash

##SLURM scheduler directives
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --mem=40GB
#SBATCH --job-name=picard_markdup
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/step0708_markdupindex/markdup/mark_%j_%a.out
#SBATCH --array=86-172

i=${SLURM_ARRAY_TASK_ID}
formID=$(printf '%.3d' "${i}")

indir=/scratch/ajj7988/results/85_samples/step0506_sortindex
outdir=/scratch/ajj7988/results/85_samples/step0708_markdupindex

module purge
module load picard/2.27.5

PICARD=/share/apps/picard/2.27.5/picard.jar

java -Xmx32g -Xms32g -jar $PICARD MarkDuplicates \
      I=${indir}/sorted_aligned_H5LGVDRX5_WGS_C_hirsuta_${formID}.bam \
      O=${outdir}/marked_duplicates_H5LGVDRX5_WGS_C_hirsuta_${formID}.bam \
      M=${outdir}/metrics/marked_dup_metrics_H5LGVDRX5_WGS_C_hirsuta_${formID}.txt

chmod u+x /scratch/ajj7988/results/85_samples/step0708_markdupindex/marked_duplicates_H5LGVDRX5_WGS_C_hirsuta_${formID}.bam
