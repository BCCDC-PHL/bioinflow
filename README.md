# Amplicone - Amplicon rEad simulator 

(IN DEVELOPMENT) 
A Nextflow pipeline for running  [ART](https://doi.org/10.1093/bioinformatics/btr708) with modifications to support amplicon read simulations with the option to have user supplied depths of each amplicon. 


![push master](https://github.com/BCCDC-PHL/ampliclone/actions/workflows/push_master.yml/badge.svg)


```mermaid
flowchart TD
    fasta[fasta directory] --> ampToFasta[convertFastaToAmplicons]
    primer_bed[primer.bed] --> ampToFasta[convertFastaToAmplicons]
    ampToFasta --> ART[runART] --> fastq[fastq]
    amplicon_depths[amplicon_depths.csv] --> VariableART[runArtVariableDepths]
    ampToFasta --> VariableART[runArtVariableDepths] --> VariableFastq[fastq with user specified individual amplicon depths]
```







