#!/bin/bash

##SLURM scheduler directives
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --mem=22GB
#SBATCH --job-name=sam_to_bam
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/step04_samtobam/sam_to_bam_%j_%a.out
#SBATCH --array=86-172

i=${SLURM_ARRAY_TASK_ID}
formID=$(printf '%.3d' "${i}")

module purge
module load samtools/intel/1.14

samtools view -h -b -f 2 -o /scratch/ajj7988/results/85_samples/step04_samtobam/aligned_H5LGVDRX5_WGS_C_hirsuta_${formID}.bam \
	/scratch/ajj7988/results/85_samples/step0203_bwa_align/aligned_H5LGVDRX5_WGS_C_hirsuta_${formID}.sam
