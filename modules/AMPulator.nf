process convertFastaToAmplicons {
    tag { sampleName }


    
    cpus 1

    input:
    path(bed)
    path(fasta_dir),

    output:
    tuple val(sampleName), path('*amplicon.fasta')

    script:

    """
    convert_fasta_to_amplicons.py --bed_file ${bed} --reference_directory ${fasta_dir} --output_directory amplicon_fastas
    """








}
