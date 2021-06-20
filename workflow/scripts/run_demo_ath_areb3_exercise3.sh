#!/bin/bash
export WD=$PWD
echo "=====Exercise: motif discovery with all peaks"
mkdir -p results/gem_01_memechip01/bZIP_tnt/AREB3_Col-B_v3
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "awk -v FS='\t' -v OFS='\t' '{ sub(/chr/,\"\",\$1); print }' nuc1_GEM_events.top600.narrowPeak | bedtools slop -b 0 -i stdin -g $WD/resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/WholeGenomeFasta/genome.chrom.sizes | bedtools getfasta -fi $WD/resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/WholeGenomeFasta/genome.fa -bed stdin -fo nuc1_GEM_events.top600.narrowPeak.fa"
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "meme-chip -oc results/gem_01_memechip00/bZIP_tnt/AREB3_Col-B_v3 -db resources/meme_motif_db/motif_databases.12.21/ARABD/ArabidopsisDAPv1.meme -meme-p 1 results/gem_01/bZIP_tnt/AREB3_Col-B_v3/nuc1/nuc1_GEM_events.top600.narrowPeak.fa 2>&1 | tee results/gem_01_memechip00/bZIP_tnt/AREB3_Col-B_v3/meme-chip.log"

