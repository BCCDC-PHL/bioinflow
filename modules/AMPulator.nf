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
    path(amplicon_fasta)
    path(bed)
    path(model_R1)
    path(model_R2)
    val(depth)
    val(fragment_mean)
    val(fragment_sd)
    

    output:
    path("*fq.qz")


    script:
    """

    IFS=" " read -ra input_array <<< "${amplicon_fasta}"

    for fasta in "${input_array[@]}"; do done

    
    
    """

}


