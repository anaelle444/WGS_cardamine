#!/bin/bash

#SBATCH --time=04:00:00
#SBATCH --mem=40GB
#SBATCH --tasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu

#SBATCH --job-name=PLINK4
#SBATCH --error=/scratch/ajj7988/log/week4/85samples/PLINK/cond4_%A.err
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/PLINK/cond4_%A.out

#SBATCH --array=1-8

i=${SLURM_ARRAY_TASK_ID}

module load plink/1.90b6.21
module load r/gcc/4.2.0

indir=/scratch/ajj7988/results/85_samples/verification/cond4
outdir=/scratch/ajj7988/results/85_samples/verification/plink/cond4

INVCF=${indir}/chr${i}_allfiltered_intermediate_H5LGVDRX5_WGS_C_hirsuta.vcf.gz
OUTPRELD=${outdir}/chr${i}_allfiltered_H5LGVDRX5_WGS_C_hirsuta_OUTPRELD
OUTPREPCA=${outdir}/chr${i}_allfiltered_H5LGVDRX5_WGS_C_hirsuta_OUTPUT


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

