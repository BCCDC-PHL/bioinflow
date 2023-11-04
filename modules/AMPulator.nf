process convertFastaToAmplicons {
    tag { sampleName }

    publishDir "${params.outdir}/amplicon_fastas", mode: 'copy', pattern: "*amplicon.fasta"
    
    cpus 1

    input:
    path(bed)
    path(fasta_dir)

    output:
    path('*amplicon.fasta')

    script:

    """
    convert_fasta_to_amplicons.py --bed_file ${bed} --reference_directory ${fasta_dir} --output_directory .
    """


}


process runART {

    tag {sampleName}

    cpus 8

    input:
    path(amplicon_fastas)

    output:
    path("*fq.qz")


    script:
    """
    echo "test"
    """







}

