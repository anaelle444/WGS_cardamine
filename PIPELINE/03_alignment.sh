#!/bin/bash

##SLURM scheduler directives

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12
#SBATCH --time=05:00:00
#SBATCH --mem=40GB
#SBATCH --job-name=loopbbduk
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/mon24/2_alignement_%j_%a.out
#SBATCH --array=86-172

module purge
module load bwa-mem2/2.1

i=${SLURM_ARRAY_TASK_ID}
formID=$(printf '%.3d' "${i}")

ref=/scratch/ajj7988/data/cardamina_fastq/CHIR.fasta ##REFERENCE INDEXED FIRST

read1=/scratch/ajj7988/results/85_samples/step01/trimmed_H5LGVDRX5_n01_WGS_C_hirsuta_${formID}.fastq.gz
read2=/scratch/ajj7988/results/85_samples/step01/trimmed_H5LGVDRX5_n02_WGS_C_hirsuta_${formID}.fastq.gz

bwa-mem2 mem -t 11 $ref $read1 $read2 > /scratch/ajj7988/results/85_samples/step02/aligned_H5LGVDRX5_WGS_C_hirsuta_${formID}.sam
