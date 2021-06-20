#!/bin/bash
export WD=$PWD
echo "=====Exercise: motif discovery with all peaks"
cd results/gem_01/bZIP_tnt/AREB3_Col-B_v3/nuc1
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "bedtools getfasta -fi $WD/resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/WholeGenomeFasta/genome.fa -bed nuc1_GEM_events.narrowPeak -fo nuc1_GEM_events.narrowPeak.fa"
cd $WD
mkdir -p results/gem_01_memechip02/bZIP_tnt/AREB3_Col-B_v3
singularity exec $WD/envs/singularity/genericdata/ch-env_latest.sif /bin/bash -c "meme-chip -oc results/gem_01_memechip02/bZIP_tnt/AREB3_Col-B_v3 -db resources/meme_motif_db/motif_databases.12.21/ARABD/ArabidopsisDAPv1.meme -meme-p 1 results/gem_01/bZIP_tnt/AREB3_Col-B_v3/nuc1/nuc1_GEM_events.narrowPeak.fa 2>&1 | tee results/gem_01_memechip02/bZIP_tnt/AREB3_Col-B_v3/meme-chip.log"

