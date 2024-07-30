#!/bin/bash

##SLURM scheduler directives
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=00:40:00
#SBATCH --mem=10GB
#SBATCH --job-name=index_markdup
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/step0708_markdupindex/index/index_bam_markdup_%j_%a.out
#SBATCH --array=86-172

i=${SLURM_ARRAY_TASK_ID}
formID=$(printf '%.3d' "${i}")

module purge
module load samtools/intel/1.14

samtools index /scratch/ajj7988/results/85_samples/step0708_markdupindex/marked_duplicates_H5LGVDRX5_WGS_C_hirsuta_${formID}.bam
