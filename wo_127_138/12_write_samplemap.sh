#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --mem=5GB
#SBATCH --job-name=samplemap
#SBATCH --mail-type=END
#SBATCH --mail-user=ajj7988@nyu.edu
#SBATCH --output=/scratch/ajj7988/log/week6/samplemap/cohort_%j.out

chr=$1

file_name="/scratch/ajj7988/results/85_samples/wo_127_138/samplemap/chr${chr}_cohorte.sample_map"
tab="	"

for i in {86..126} {128..137} {139..172}; do
	formID=$(printf '%.3d' "${i}")
	echo -e "Sample${formID}\t/scratch/ajj7988/results/85_samples/step1112_haplo_map/H5LGVDRX5_WGS_C_hirsuta_${formID}_chr${chr}.gvcf.gz" >> "$file_name" ;
done;

chmod u+x ${file_name}
