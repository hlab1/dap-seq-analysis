#!/bin/bash
export WD=$PWD
mkdir -p resources/demo_data
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif fastq-dump --gzip --outdir resources/demo_data SRR2926843
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif fastq-dump --split-3 --gzip --outdir resources/demo_data SRR2926068
