#!/bin/bash
export WD=$PWD
#echo "=====Start downloading test data====="
#sh ./get_data_ath_areb3.sh
echo "=====Start adapter trimming====="
mkdir -p results/fq_trimgalore_01/SRR2926843
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif trim_galore -q 20 --fastqc --output_dir results/fq_trimgalore_01/SRR2926843 --basename AREB3_Col-B_v3_SRR2926843_R1 resources/demo_data/SRR2926843.fastq.gz 2>&1 | tee results/fq_trimgalore_01/SRR2926843/AREB3_Col-B_v3_SRR2926843_R1.log
echo "=====Start read mapping====="
mkdir -p results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "bowtie2 -x resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Bowtie2Index/genome -U results/fq_trimgalore_01/SRR2926843/AREB3_Col-B_v3_SRR2926843_R1_trimmed.fq.gz -S results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.sam 2>&1 | tee results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.log"
singularity exec envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "samtools view -bSu results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.sam | samtools sort -o results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.bam -T results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.bam"
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif samtools index results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.bam
echo "=====Start filtering for MAPQ30====="
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "samtools view -u -q 30 results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.bam 1 2 3 4 5 | samtools sort -o results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.q30nuc.bam -T results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.q30nuc.bam"
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif samtools index results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.q30nuc.bam
echo "=====Start GEM peak calling====="
mkdir -p results/gem_01/bZIP_tnt/AREB3_Col-B_v3
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "cd results/gem_01/bZIP_tnt/AREB3_Col-B_v3; java -jar /apps/gem/3.3/gem.jar --d /apps/gem/3.3/Read_Distribution_default.txt --g $WD/resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/WholeGenomeFasta/genome.chrom.sizes --genome $WD/resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Chromosomes_CHR --subs 1 2 3 4 5 --exptAREB3_Col-B_v3 $WD/results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.q30nuc.bam --f SAM --out nuc1 --t 1 --k_min 5 --k_max 14 --k_seqs 2000 --outNP --outBED --outMEME --outJASPAR --outHOMER --k_neg_dinu_shuffle --print_bound_seqs --print_aligned_seqs"
cd results/gem_01/bZIP_tnt/AREB3_Col-B_v3/nuc1
awk -v FS='\t' -v OFS='\t' '{ sub(/chr/,"",$1); print }' nuc1.GEM_events.narrowPeak > nuc1_GEM_events.narrowPeak
sort -k9,9nr -k7,7nr nuc1_GEM_events.narrowPeak | head -600 > nuc1_GEM_events.top600.narrowPeak
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "bedtools slop -b 0 -i nuc1_GEM_events.top600.narrowPeak -g $WD/resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/WholeGenomeFasta/genome.chrom.sizes | bedtools getfasta -fi $WD/resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/WholeGenomeFasta/genome.fa -bed stdin -fo nuc1_GEM_events.top600.narrowPeak.fa"
echo "=====Start running MEME motif discovery====="
cd $WD
mkdir -p results/gem_01_memechip00/bZIP_tnt/AREB3_Col-B_v3
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "meme-chip -oc results/gem_01_memechip00/bZIP_tnt/AREB3_Col-B_v3 -db resources/meme_motif_db/motif_databases.12.21/ARABD/ArabidopsisDAPv1.meme -meme-p 1 results/gem_01/bZIP_tnt/AREB3_Col-B_v3/nuc1/nuc1_GEM_events.top600.narrowPeak.fa 2>&1 | tee results/gem_01_memechip00/bZIP_tnt/AREB3_Col-B_v3/meme-chip.log"
