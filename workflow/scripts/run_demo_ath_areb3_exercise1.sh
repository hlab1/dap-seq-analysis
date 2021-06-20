#!/bin/bash
export WD=$PWD
echo "=====Exercise: adding control in peak calling"
mkdir -p results/fq_trimgalore_01/SRR2926068
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif trim_galore -q 20 --fastqc --output_dir results/fq_trimgalore_01/SRR2926068 --basename beads_Col-B_v3a_SRR2926068_R1 resources/demo_data/SRR2926068_1.fastq.gz 2>&1 | tee results/fq_trimgalore_01/SRR2926068/beads_Col-B_v3a_SRR2926068_R1.log
echo "=====Start read mapping====="
mkdir -p results/bowtie2_01/control_tnt/beads_Col-B_v3a
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "bowtie2 -x resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Bowtie2Index/genome -U results/fq_trimgalore_01/SRR2926068/beads_Col-B_v3a_SRR2926068_R1_trimmed.fq.gz -S results/bowtie2_01/control_tnt/beads_Col-B_v3a/beads_Col-B_v3a.sam 2>&1 | tee results/bowtie2_01/control_tnt/beads_Col-B_v3a/beads_Col-B_v3a.log"
singularity exec envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "samtools view -bSu results/bowtie2_01/control_tnt/beads_Col-B_v3a/beads_Col-B_v3a.sam | samtools sort -o results/bowtie2_01/control_tnt/beads_Col-B_v3a/beads_Col-B_v3a.bam -T results/bowtie2_01/control_tnt/beads_Col-B_v3a/beads_Col-B_v3a.bam"
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif samtools index results/bowtie2_01/control_tnt/beads_Col-B_v3a/beads_Col-B_v3a.bam
echo "=====Start filtering for MAPQ30====="
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "samtools view -u -q 30 results/bowtie2_01/control_tnt/beads_Col-B_v3a/beads_Col-B_v3a.bam 1 2 3 4 5 | samtools sort -o results/bowtie2_01/control_tnt/beads_Col-B_v3a/beads_Col-B_v3a.q30nuc.bam -T results/bowtie2_01/control_tnt/beads_Col-B_v3a/beads_Col-B_v3a.q30nuc.bam"
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif samtools index results/bowtie2_01/control_tnt/beads_Col-B_v3a/beads_Col-B_v3a.q30nuc.bam
echo "=====Start GEM peak calling====="
mkdir -p results/gem_02/bZIP_tnt/AREB3_Col-B_v3
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "cd results/gem_02/bZIP_tnt/AREB3_Col-B_v3; java -jar /apps/gem/3.3/gem.jar --d /apps/gem/3.3/Read_Distribution_default.txt --g $WD/resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/WholeGenomeFasta/genome.chrom.sizes --genome $WD/resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Chromosomes_CHR --subs 1 2 3 4 5 --exptAREB3_Col-B_v3 $WD/results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.q30nuc.bam --ctrlAREB3_Col-B_v3 $WD/results/bowtie2_01/control_tnt/beads_Col-B_v3a/beads_Col-B_v3a.q30nuc.bam --f SAM --out nuc1 --t 1 --k_min 5 --k_max 14 --k_seqs 2000 --outNP --outBED --outMEME --outJASPAR --outHOMER --k_neg_dinu_shuffle --print_bound_seqs --print_aligned_seqs"
