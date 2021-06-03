#/bin/bash
wget -P resources/Illumina_iGenomes http://igenomes.illumina.com.s3-website-us-east-1.amazonaws.com/Arabidopsis_thaliana/Ensembl/TAIR10/Arabidopsis_thaliana_Ensembl_TAIR10.tar.gz
tar -C resources/Illumina_iGenomes -zxvf resources/Illumina_iGenomes/Arabidopsis_thaliana_Ensembl_TAIR10.tar.gz
cut -f1,2 resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/WholeGenomeFasta/genome.fa.fai > resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/WholeGenomeFasta/genome.chrom.sizes
mkdir -p resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Chromosomes_CHR
for f in 1 2 3 4 5 Mt Pt; do ln -rs "resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Chromosomes/$f.fa" "resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Chromosomes_CHR/chr$f.fa"; done
wget -P resources/meme_motif_db https://meme-suite.org/meme/meme-software/Databases/motifs/motif_databases.12.21.tgz
tar -C resources/meme_motif_db -zxvf resources/meme_motif_db/motif_databases.12.21.tgz
mv resources/meme_motif_db/motif_databases resources/meme_motif_db/motif_databases.12.21
