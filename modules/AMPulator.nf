process convertFastaToAmplicons {
    tag { sampleName }

    publishDir "${params.outdir}/amplicon_fastas", mode: 'copy', pattern: "*amplicon.fasta"
    
    cpus 1

    input:
    path(bed)
    path(fasta_dir)

    output:
    path('*amplicon.fasta'), emit: amplicon_fastas

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
    art_illumina -1 ${params.model_R1} -2 ${params.model_R2} -i ${amplicon.fasta} -f ${params.depth} -l 150 -p -m ${params.fragment_mean} -s ${params.fragment_sd} -o ${amplicon.fasta}_R
    """







}

