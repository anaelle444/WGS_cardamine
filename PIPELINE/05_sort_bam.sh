#!/bin/bash

##SLURM scheduler directives
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00
#SBATCH --mem=10GB
#SBATCH --job-name=sort_bam
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/step0506_sortindex/sort/sort_bam_%j_%a.out
#SBATCH --array=86-172

i=${SLURM_ARRAY_TASK_ID}
formID=$(printf '%.3d' "${i}")

module purge
module load samtools/intel/1.14

samtools sort -o /scratch/ajj7988/results/85_samples/step0506_sortindex/sorted_aligned_H5LGVDRX5_WGS_C_hirsuta_${formID}.bam \
	-O bam /scratch/ajj7988/results/85_samples/step04_samtobam/aligned_H5LGVDRX5_WGS_C_hirsuta_${formID}.bam

chmod u+x /scratch/ajj7988/results/85_samples/step0506_sortindex/sorted_aligned_H5LGVDRX5_WGS_C_hirsuta_${formID}.bam
