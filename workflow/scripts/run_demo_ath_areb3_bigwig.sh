#!/bin/bash
mkdir -p results/jbrowse/bowtie2_01
module purge; module load deeptools/3.5.0
files="bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3 bZIP_tnt/AREB3_Colamp-B_a/AREB3_Colamp-B_a control_tnt/beads_Col-B_v3a/beads_Col-B_v3a"
for f in $files
do
    echo $f
    out_prefix=$WD/results/jbrowse/bowtie2_01/$f
    mkdir -p $(dirname $out_prefix)
    outf1=$out_prefix.ext200_1bp_rpkm.bw
    bamCoverage --bam $WD/results/bowtie2_01/$f.bam\
		--outFileName $outf1\
		--outFileFormat bigwig\
		--numberOfProcessors 2\
		--ignoreForNormalization Mt Pt\
		--extendReads 200\
		--binSize 1 --normalizeUsing RPKM\
		2>&1 | tee $outf1.log
    outf2=$out_prefix.q30nuc_ext200_1bp_rpkm.bw
    bamCoverage --bam $WD/results/bowtie2_01/$f.q30nuc.bam\
		--outFileName $outf2\
		--outFileFormat bigwig\
		--numberOfProcessors 2\
		--ignoreForNormalization Mt Pt\
		--extendReads 200\
		--binSize 1 --normalizeUsing RPKM\
		2>&1 | tee $outf2.log
done

