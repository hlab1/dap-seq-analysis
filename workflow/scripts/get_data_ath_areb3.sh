#!/bin/bash
export WD=$PWD
echo "=====Start downloading test data====="
mkdir -p resources/demo_data
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif fastq-dump --gzip --outdir resources/demo_data SRR2926843
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif fastq-dump --split-3 --gzip --outdir resources/demo_data SRR2926068
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif fastq-dump --gzip --outdir resources/demo_data SRR2926842
echo "=====Start adapter trimming====="
mkdir -p results/fq_trimgalore_01/SRR2926843
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif trim_galore -q 20 --fastqc --output_dir results/fq_trimgalore_01/SRR2926843 --basename AREB3_Col-B_v3_SRR2926843_R1 resources/demo_data/SRR2926843.fastq.gz 2>&1 | tee results/fq_trimgalore_01/SRR2926843/AREB3_Col-B_v3_SRR2926843_R1.log
mkdir -p results/fq_trimgalore_01/SRR2926842
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif trim_galore -q 20 --fastqc --output_dir results/fq_trimgalore_01/SRR2926842 --basename AREB3_Colamp-B_a_SRR2926842_R1 resources/demo_data/SRR2926842.fastq.gz 2>&1 | tee results/fq_trimgalore_01/SRR2926842/AREB3_Colamp-B_a_SRR2926842_R1.log
mkdir -p results/fq_trimgalore_01/SRR2926068
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif trim_galore -q 20 --fastqc --output_dir results/fq_trimgalore_01/SRR2926068 --basename beads_Col-B_v3a_SRR2926068_R1 resources/demo_data/SRR2926068_1.fastq.gz 2>&1 | tee results/fq_trimgalore_01/SRR2926068/beads_Col-B_v3a_SRR2926068_R1.log
