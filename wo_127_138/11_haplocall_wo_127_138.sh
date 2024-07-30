#!/bin/bash

##SLURM scheduler directives
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --time=04:00:00
#SBATCH --mem=34GB
#SBATCH --job-name=haplocall
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week6/without_127_138/11_haplo%j_%a.out
#SBATCH --error=/scratch/ajj7988/log/week6/without_127_138/11_haplo%j_%a.err
#SBATCH --array=86-126,128-137,139-172

i=${SLURM_ARRAY_TASK_ID}
formID=$(printf '%.3d' "${i}")

chr=$1

if [ "$chr" -eq 1 ]; then
    interval="chr1:1-26630727"
elif [ "$chr" -eq 2 ]; then
    interval="chr2:1-22979278"
elif [ "$chr" -eq 3 ]; then
    interval="chr3:1-23488319"
elif [ "$chr" -eq 4 ]; then
    interval="chr4:1-25331790"
elif [ "$chr" -eq 5 ]; then
    interval="chr5:1-23869648"
elif [ "$chr" -eq 6 ]; then
    interval="chr6:1-25363233"
elif [ "$chr" -eq 7 ]; then
    interval="chr7:1-25567688"
elif [ "$chr" -eq 8 ]; then
    interval="chr8:1-19990553"
else
    echo "Valeur de chr non reconnue : $chr"
    exit 1
fi

module purge
module load gatk/4.3.0.0
module load samtools/intel/1.14

ref=/scratch/ajj7988/data/cardamina_fastq/CHIR.fasta
dict=/scratch/ajj7988/data/cardamina_fastq/CHIR.dict

input=/scratch/ajj7988/results/85_samples/step10_addRG/RG_added_H5LGVDRX5_WGS_C_hirsuta_${formID}.bam
output=/scratch/ajj7988/results/85_samples/step1112_haplo_map/H5LGVDRX5_WGS_C_hirsuta_${formID}_chr${chr}.gvcf.gz

samtools index ${input}

#echo "input:     ${input}"
#echo "output:    ${output}"
#echo "i:         ${i}"
#echo "formID:    ${formID}"
#echo "ref:       ${ref}"

#if [ -e "${input}" ]
#then
#	echo "Input exists"
#else
#	echo "Input doesn't exist"
#fi

gatk --java-options "-Xmx32g -Xms32g -XX:ParallelGCThreads=2" HaplotypeCaller  \
  -R ${ref} \
  -I ${input} \
  -O ${output} \
  -L $interval \
  -ERC GVCF

chmod u+x ${output}
