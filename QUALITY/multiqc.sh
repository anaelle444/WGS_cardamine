#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00
#SBATCH --mem=22GB
#SBATCH --job-name=multiqc
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/multiqc/wednesday_%j.out

module purge
module load multiqc/1.17

input_dir="/scratch/ajj7988/results/85_samples/step01_bbduk"
output="/scratch/ajj7988/results/85_samples/step01_bbduk/qualcontrl/multiqc_report.html"

multiqc ${input_dir} > ${output}

