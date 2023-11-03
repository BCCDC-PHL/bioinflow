process convertFastaToAmplicons {
    tag{ sampleName }

    publishDir "${params.outdir}/amplicon_fastas", pattern 'amplicon_fastas/*amplicon.fasta', mode: 'copy'
    
    cpus 1

    input:
    tuple val(sampleName), path(fasta_dir), path(bed)

    output:
    tuple val(sampleName), path("*amplicon.fasta")

    script:

    """
    convert_fasta_to_amplicons.py --bed_file $bed --reference_directory $fasta_dir --output_directory amplicon_fastas
    """








}