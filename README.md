# Amplicone - Amplicon rEad simulator 

(IN DEVELOPMENT) Takes a reference fasta and primer bed file and generates simulated amplicon reads using [ART](https://doi.org/10.1093/bioinformatics/btr708). User can vary depth of individual amplicons. 


```mermaid
flowchart TD
    fasta[fasta directory] --> ampToFasta[convertFastaToAmplicons]
    primer_bed[primer.bed] --> ampToFasta[convertFastaToAmplicons]
    ampToFasta --> ART[runART] --> fastq[fastq]
    amplicon_depths[amplicon_depths.csv] --> VariableART[runArtVariableDepths]
    ampToFasta --> VariableART[runArtVariableDepths] --> VariableFastq[fastq with user specified individual amplicon depths]
```
