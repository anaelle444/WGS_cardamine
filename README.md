# WGS analysis *C. hirsuta* 

## Description

This repository contains all the scripts which are required in order to analyze the whole genome sequencing data for 86 *C. hirsuta* accessions. 

## Overview

The repository contains all the scripts to run preprocessing of the data, mapping, variant calling, hardfiltering and assessing the extent of population structure. All major steps of the pipeline are summarized below. All the scripts are named in chronological order and contain comments to guide the usage of each script.

This repository contains three different folders: the **pipeline**, the **quality control** scripts, and ***wo_127_138***, which includes the analysis of the data where samples 127 and 138 were removed to explore hypotheses explaining the overall genome variation.

## Dependencies

- vcftools (v0.1.16)

- bcftools (v1.14)

- bwa (v0.7.17)

- samtools (v1.14)

- picard tools (v2.23.8)

- GATK (4.3.0.0)

- PLINK (v1.90b6.2)

- bbtools (v38.91)
  
- R (v4.2.0)

    - tidyverse (v2.0.0)

    - ggplot2 (v 3.4.4)

    - argparser (v0.7.1)

    - viridis (v0.6.3)

    - ggrepel (v0.9.1)

    - ggpmisc (v0.5.4-1)

