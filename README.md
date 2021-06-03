# dap-seq-analysis
This repository contains code and instructions for a tutorial of analysis of DAP-seq data.

## Testing using AREB3 data
Clone this repo.  Then **enter the package directory** to run the following scripts.
1. Run `workflow/scripts/get_singularity_chenv.sh` to pull the `genericdata/ch-env` container.
   - The Docker image is now at `envs/genericdata/ch-env_latest.sif`
2. Run `workflow/scripts/get_genome_tair10.sh` to download (a) TAIR10 genome information, (2) DAP-seq motif database, and set up the support files needed for later steps.
   -  The Arabidopsis genome information files are in `resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10`.
   -  The Arabidopsis DAP-seq motifs are in `resources/meme_motif_db/motif_databases.12.21/ARABD`.
3. Run `workflow/scripts/run_demo_ath_areb3.sh` to download the AREB3 test data from SRA and perform trimming, mapping, peak calling and motif discovery.
   -  Gzipped FASTQ of sequencing reads is `resources/demo_data/resources/demo_data/SRR2926843.fastq.gz`
   -  Trimmed FASTQ is `results/fq_trimgalore_01/SRR2926843/AREB3_Col-B_v3_SRR2926843_R1_trimmed.fq.gz`
   -  BAM file of mapped reads is `results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.bam`
   -  BAM file of MAPQ>=30 reads is `results/bowtie2_01/bZIP_tnt/AREB3_Col-B_v3/AREB3_Col-B_v3.q30nuc.bam`
   -  GEM peak calling results are in `results/gem_01/bZIP_tnt/AREB3_Col-B_v3/nuc1`
   -  narrowPeak file for top 600 peaks is `results/gem_01/bZIP_tnt/AREB3_Col-B_v3/nuc1/nuc1_GEM_events.top600.narrowPeak`
   -  FASTA sequences of top 600 peaks are in `results/gem_01/bZIP_tnt/AREB3_Col-B_v3/nuc1/nuc1_GEM_events.top600.narrowPeak.fa`
   -  MEME reults are in `results/gem_01_memechip00/bZIP_tnt/AREB3_Col-B_v3`

## Dependencies
- Docker container https://hub.docker.com/r/genericdata/ch-env or dockerfile https://github.com/genericdata/ch-env/blob/main/Dockerfile.
  - Contains the packages needed in running a basic DAP-seq analysis pipeline
  

