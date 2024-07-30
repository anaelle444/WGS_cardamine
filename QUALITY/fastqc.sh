#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --time=01:00:00
#SBATCH --mem=22GB
#SBATCH --job-name=fastqc
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/fastqc/_%j.out
#SBATCH --array=86-172

i=${SLURM_ARRAY_TASK_ID}
formID=$(printf '%.3d' "${i}")

input1=/scratch/ajj7988/results/85_samples/step01_bbduk/trimmed_H5LGVDRX5_n01_WGS_C_hirsuta_${formID}.fastq.gz
input2=/scratch/ajj7988/results/85_samples/step01_bbduk/trimmed_H5LGVDRX5_n02_WGS_C_hirsuta_${formID}.fastq.gz

chmod +x ${input1}
chmod +x ${input2}

module purge
module load fastqc/0.11.9

fastqc ${input1}
fastqc ${input2}
