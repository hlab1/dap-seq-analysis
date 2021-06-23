#!/bin/bash
export WD=$PWD
mkdir -p results/bowtie2_01/bZIP_tnt/AREB3_Colamp-B_a
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "bowtie2 -x resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Bowtie2Index/genome -U results/fq_trimgalore_01/SRR2926842/AREB3_Colamp-B_a_SRR2926842_R1_trimmed.fq.gz -S results/bowtie2_01/bZIP_tnt/AREB3_Colamp-B_a/AREB3_Colamp-B_a.sam 2>&1 | tee results/bowtie2_01/bZIP_tnt/AREB3_Colamp-B_a/AREB3_Colamp-B_a.log"
singularity exec envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "samtools view -bSu results/bowtie2_01/bZIP_tnt/AREB3_Colamp-B_a/AREB3_Colamp-B_a.sam | samtools sort -o results/bowtie2_01/bZIP_tnt/AREB3_Colamp-B_a/AREB3_Colamp-B_a.bam -T results/bowtie2_01/bZIP_tnt/AREB3_Colamp-B_a/AREB3_Colamp-B_a.bam"
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif samtools index results/bowtie2_01/bZIP_tnt/AREB3_Colamp-B_a/AREB3_Colamp-B_a.bam
echo "=====Start filtering for MAPQ30====="
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "samtools view -u -q 30 results/bowtie2_01/bZIP_tnt/AREB3_Colamp-B_a/AREB3_Colamp-B_a.bam 1 2 3 4 5 | samtools sort -o results/bowtie2_01/bZIP_tnt/AREB3_Colamp-B_a/AREB3_Colamp-B_a.q30nuc.bam -T results/bowtie2_01/bZIP_tnt/AREB3_Colamp-B_a/AREB3_Colamp-B_a.q30nuc.bam"
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif samtools index results/bowtie2_01/bZIP_tnt/AREB3_Colamp-B_a/AREB3_Colamp-B_a.q30nuc.bam
echo "=====Start GEM peak calling====="
mkdir -p results/gem_01/bZIP_tnt/AREB3_Colamp-B_a
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "cd results/gem_01/bZIP_tnt/AREB3_Colamp-B_a; java -Xmx6G -jar /apps/gem/3.3/gem.jar --d /apps/gem/3.3/Read_Distribution_default.txt --g $WD/resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/WholeGenomeFasta/genome.chrom.sizes --genome $WD/resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Chromosomes_CHR --subs \"1 2 3 4 5\" --exptAREB3_Colamp-B_a $WD/results/bowtie2_01/bZIP_tnt/AREB3_Colamp-B_a/AREB3_Colamp-B_a.q30nuc.bam --f SAM --out nuc1 --t 1 --k_min 5 --k_max 14 --k_seqs 2000 --outNP --outBED --outMEME --outJASPAR --outHOMER --k_neg_dinu_shuffle --print_bound_seqs --print_aligned_seqs"
