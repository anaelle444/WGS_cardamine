#!/bin/bash

#SBATCH --time=02:00:00
#SBATCH --mem=20GB
#SBATCH --tasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu

#SBATCH --job-name=findK
#SBATCH --error=/scratch/ajj7988/log/week6/Admixture/findK_%A.err
#SBATCH --output=/scratch/ajj7988/log/week6/Admixture/findK_%A.out


module purge
module load admixture/1.3.0

indir=/scratch/ajj7988/results/85_samples/step18_plink
outdir=/scratch/ajj7988/results/85_samples/

cd ${outdir}

for K in {8..10}; do
	admixture --cv ${indir}/CHIR_allCHROM_r2_OUTPUT.bed $K | tee ${outdir}/log${K}.out;
done
