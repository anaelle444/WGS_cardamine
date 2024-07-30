#!/bin/bash

#SBATCH --mem=4GB
#SBATCH --time=01:00:00
#SBATCH --job-name=merge_vcfs
#SBATCH --error=/scratch/ajj7988/log/week6/merge_plink/merge_vcfs_%A.err
#SBATCH --output=/scratch/ajj7988/log/week6/merge_plink/merge_vcfs_%A.out
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --tasks=1
#SBATCH --cpus-per-task=2

module purge
module load picard/2.27.5
module load bcftools/intel/1.14
module load samtools/intel/1.14

PICARD_JAR=/share/apps/picard/2.27.5/picard.jar


VCFDIR="/scratch/ajj7988/results/85_samples/wo_127_138/hardfilter"
OUTFILE="/scratch/ajj7988/results/85_samples/wo_127_138/merge_plink/CHIR_allCHROM_r2.vcf.gz"
INLIST="${VCFDIR}/vcflist_ChirChr_vcf.list"


echo "Merging vcfs with the following settings"
echo "VCFDIR:         ${VCFDIR}"
echo "OUTFILE:        ${OUTFILE}"
echo "INLIST:         ${INLIST}"


#find ${VCFDIR} -name "chr*_selected_H5LGVDRX5_WGS_C_hirsuta.vcf.gz" -exec echo "{}" \; > ${INLIST}

#java -jar ${PICARD_JAR} MergeVcfs \
         -I ${INLIST} \
         -O ${OUTFILE}

tabix -f ${OUTFILE}
