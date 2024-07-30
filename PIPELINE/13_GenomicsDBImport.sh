#!/bin/bash

##SLURM scheduler directives
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=04:00:00
#SBATCH --mem=60GB
#SBATCH --job-name=chr%j_import
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week4/85samples/step13_Import/DB_chr_%j_%a.out
#SBATCH --array=1-8

i=${SLURM_ARRAY_TASK_ID}

if [ "$i" -eq 1 ]; then
    interval="chr1:1-26630727"
elif [ "$i" -eq 2 ]; then
    interval="chr2:1-22979278"
elif [ "$i" -eq 3 ]; then
    interval="chr3:1-23488319"
elif [ "$i" -eq 4 ]; then
    interval="chr4:1-25331790"
elif [ "$i" -eq 5 ]; then
    interval="chr5:1-23869648"
elif [ "$i" -eq 6 ]; then
    interval="chr6:1-25363233"
elif [ "$i" -eq 7 ]; then
    interval="chr7:1-25567688"
elif [ "$i" -eq 8 ]; then
    interval="chr8:1-19990553"
else
    echo "Valeur de i non reconnue : $i"
    exit 1
fi


module purge
module load gatk/4.3.0.0

samplemap=/scratch/ajj7988/results/85_samples/step1112_haplo_map/sample_map
outdir=/scratch/ajj7988/results/85_samples/step13_DBImport

gatk --java-options "-Xmx60g -Xms60g"  GenomicsDBImport \
     --genomicsdb-workspace-path ${outdir}/DB_chr${i} \
     --batch-size 3 \
     -L $interval \
     --sample-name-map ${samplemap}/chr${i}_cohorte.sample_map \
     --tmp-dir ${outdir}/tmp \
     --reader-threads 5


info_debug=/scratch/ajj7988/log/week4/85samples/step13_Import/debug_chr_${i}.txt
echo "Interval: 	${interval}" >> ${info_debug}
echo "Sample map: 	${samplemap}/chr${i}_cohorte.sample_map" >> ${info_debug}
echo "Outdir:	 	${outdir}/DB_chr${i}" >> ${info_debug}
echo "i:         	${i}" >> ${info_debug}
echo "formID:   	${formID}" >> ${info_debug}
echo "ref:       	${ref}" >> ${info_debug}

