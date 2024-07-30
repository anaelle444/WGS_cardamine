#!/bin/bash

#SBATCH --time=04:00:00
#SBATCH --mem=40GB
#SBATCH --tasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu

#SBATCH --job-name=PLINK
#SBATCH --error=/scratch/ajj7988/log/week6/merge_plink/plink_%A.err
#SBATCH --output=/scratch/ajj7988/log/week6/merge_plink/plink_%A.out

module purge
module load plink/1.90b6.21
module load r/gcc/4.2.0

indir=/scratch/ajj7988/results/85_samples/step18_plink
outdir=/scratch/ajj7988/results/85_samples/step18_plink

INVCF=${indir}/CHIR_allCHROM_r2.vcf.gz
OUTPRELD=${outdir}/CHIR_allCHROM_r2_OUTPRELD
OUTPREPCA=${outdir}/CHIR_allCHROM_r2_OUTPUT


MIND=0.2
WINDOWSIZE=50
STEPSIZE=10
RTHRESHOLD=0.1


plink --vcf ${INVCF} \
  --double-id \
  --allow-extra-chr \
  --set-missing-var-ids @:# \
  --indep-pairwise ${WINDOWSIZE} ${STEPSIZE} ${RTHRESHOLD} \
  --out ${OUTPRELD}


echo -e "RUNNING PCA USING PLINK\n"


plink --vcf ${INVCF} \
  --double-id \
  --allow-extra-chr \
  --set-missing-var-ids @:# \
  --extract ${OUTPRELD}.prune.in \
  --make-bed \
  --pca \
  --out ${OUTPREPCA} \
  --mind ${MIND}

