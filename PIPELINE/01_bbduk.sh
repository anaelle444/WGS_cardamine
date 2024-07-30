#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --mem=22GB
#SBATCH --job-name=bbduk
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/step01/justbbduk/bbduk_%j_%a.out
#SBATCH --array=86-172

module purge 
module load bbtools/38.91

indir="/scratch/ajj7988/data/all_files_2024-05-22_H5LGVDRX5" ##INPUT DATA
outdir="/scratch/ajj7988/results/85_samples/step01" ##OUTPUT DATA WHERE
mkdir -p ${outdir}
mkdir ${outdir}/STATS

i=${SLURM_ARRAY_TASK_ID}
formID=$(printf '%.3d' "${i}")

mkdir -p ${outdir}/PAIR_n${formID}
cp ${indir}/*${formID}.fastq.gz ${outdir}/PAIR_n${formID}/ ##CREATE PAIRS OF READ 1 AND 2 SPECIFY WHERE

#bbduk.sh -Xmx20g in1=${outdir}/PAIR_n${formID}/H5LGVDRX5_n01_WGS_C_hirsuta_${formID}.fastq.gz \ #NEW READS
#    in2=${outdir}/PAIR_n${formID}/H5LGVDRX5_n02_WGS_C_hirsuta_${formID}.fastq.gz \
#    out1=${outdir}/trimmed_H5LGVDRX5_n01_WGS_C_hirsuta_${formID}.fastq.gz \ ##NAME OF OUTPUT RESULTS
#    out2=${outdir}/trimmed_H5LGVDRX5_n02_WGS_C_hirsuta_${formID}.fastq.gz \
#    ktrim=r \
#    k=25 mink=11 hdist=1 tpe tbo stats=${outdir}/STATS/stats_${formID}.txt \ #PARAMETERS # MKDIR NEW DIR FOR STATS
#    ref=/scratch/cgsb/bergelson/bergelson-lab/Hanna/Anaelle/adapters_extended.fa #USE THE NEW ADAPTER LIST 


bbduk.sh in1=/scratch/ajj7988/results/85_samples/step01/PAIR_n${formID}/H5LGVDRX5_n01_WGS_C_hirsuta_${formID}.fastq.gz \
    in2=/scratch/ajj7988/results/85_samples/step01/PAIR_n${formID}/H5LGVDRX5_n02_WGS_C_hirsuta_${formID}.fastq.gz \
    out1=/scratch/ajj7988/results/85_samples/step01/trimmed_H5LGVDRX5_n01_WGS_C_hirsuta_${formID}.fastq.gz \
    out2=/scratch/ajj7988/results/85_samples/step01/trimmed_H5LGVDRX5_n02_WGS_C_hirsuta_${formID}.fastq.gz \
    ktrim=r \
    k=25 \
    mink=11 \
    hdist=1 \
    tpe \
    tbo \
    stats=/scratch/ajj7988/results/85_samples/step01/STATS/stats_${formID}.txt \
    ref=/scratch/cgsb/bergelson/bergelson-lab/Hanna/Anaelle/adapters_extended.fa
