#!/bin/bash 

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:40:00
#SBATCH --mem=10GB
#SBATCH --job-name=1_bbduk
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/mon24/1_bbduk_%j_%a.out


file=/scratch/ajj7988/data/cardamina_fastq/CHIR.fasta 

module purge
module load bwa-mem2/2.1

bwa-mem2 index $file
