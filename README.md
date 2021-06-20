# dap-seq-analysis
This repository contains code and instructions for a tutorial of analysis of DAP-seq data.

## Testing using AREB3 data
Clone this repo.  Then **enter the package directory** to run the following scripts.  You will need about 6Gb of space.
1. Run `workflow/scripts/get_singularity_chenv.sh` to pull the `genericdata/ch-env` container.
   - The Docker image is now at `envs/singularity/genericdata/ch-env_latest.sif`
2. Run `workflow/scripts/get_genome_tair10.sh` to download (a) TAIR10 genome information, (2) MEME motif database, and set up the support files needed for later steps.
   -  The Arabidopsis genome information files are in `resources/Illumina_iGenomes/Arabidopsis_thaliana/Ensembl/TAIR10`.
   -  The Arabidopsis DAP-seq motifs are in `resources/meme_motif_db/motif_databases.12.21/ARABD`.
3. *Only needed if you want to download data from SRA.** Run `workflow/scripts/config_sratools.sh` to configure SRA tools.  See reference here https://github.com/ncbi/sra-tools/wiki/03.-Quick-Toolkit-Configuration.
   ```
   You will see a screen where you operate the buttons by pressing the letter highlighted in red, or by pressing the tab-key until the wanted button is reached and then pressing the space- or the enter-key.

1. You want to enable the "Remote Access" option on the Main screen.

2. Proceed to the "Cache" tab where you will want to enable "local file-caching" and you want to set the "Location of user-repository".

    a) The repository directory needs to be set to an empty folder. This is the folder where prefetch will deposit the files.

Go to your cloud provider tab and accept to "report cloud instance identity".
```

4. Run `workflow/scripts/run_demo_ath_areb3.sh` to download the AREB3 test data from SRA and perform trimming, mapping, peak calling and motif discovery.
   -  Gzipped FASTQ of sequencing reads is `resources/demo_data/SRR2926843.fastq.gz`
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
