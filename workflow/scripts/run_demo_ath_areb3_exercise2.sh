#!/bin/bash
export WD=$PWD
echo "=====Exercise: peak calling without MAPQ filtering"
mkdir -p results/gem_03/bZIP_tnt/AREB3_Col-B_v3
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "cd results/gem_01/bZIP_tnt/AREB3_Col-B_v3; java -jar /apps/gem/3.3/gem.jar --d /apps/gem/3.3/Read_Distribution_default.txt --g $WD/resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/WholeGenomeFasta/genome.chrom.sizes --genome $WD/resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Chromosomes_CHR --subs 1 2 3 4 5 --exptAREB3_Col-B_v3 $WD/results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.bam --f SAM --out nuc1 --t 1 --k_min 5 --k_max 14 --k_seqs 2000 --outNP --outBED --outMEME --outJASPAR --outHOMER --k_neg_dinu_shuffle --print_bound_seqs --print_aligned_seqs"
