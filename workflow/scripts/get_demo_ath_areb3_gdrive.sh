#!/bin/bash
export WD=$PWD
echo "=====Start downloading trimmed FASTQ files from Google drive====="
cd $WD/envs
git clone https://github.com/matthuisman/gdrivedl.git
cd $WD
#singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif python envs/gdrivedl/gdrivedl.py https://drive.google.com/file/d/1BVVRQhpL3gO1x8CUpdYRirx03otWdbRI/view?usp=sharing -P results/fq_trimgalore_01/SRR2926843
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif python envs/gdrivedl/gdrivedl.py https://drive.google.com/file/d/1ADjliOFcY1Vvsq-zog90Y0OCDRaLFIlq/view?usp=sharing -P resources/demo_data
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif python envs/gdrivedl/gdrivedl.py https://drive.google.com/file/d/1Vi0ZNyKdaXyql5VvkMBGqRReAI3xKWSN/view?usp=sharing -P results/fq_trimgalore_01/SRR2926842
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif python envs/gdrivedl/gdrivedl.py https://drive.google.com/file/d/1_ZnVewY0lTZAL6kefwV-GeBI-3RY2iZI/view?usp=sharing -P results/fq_trimgalore_01/SRR2926068
