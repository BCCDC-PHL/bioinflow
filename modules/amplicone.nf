process convertFastaToAmplicons {
    tag { sampleName }

    publishDir "${params.outdir}/amplicon_fastas", mode: 'copy', pattern: "*amplicon.fasta"
    
    cpus 1

    input:
    tuple val(sampleName), path(fasta)

    output:

    tuple val(sampleName), path('*amplicon.fasta')

    script:

    """
    convert_fasta_to_amplicons.py --bed_file ${params.bed} --reference_file ${fasta} 
    """


}

process runART {

    tag {sampleName}

    cpus 8

    publishDir "${params.outdir}/amplicon_fastqs", mode: 'copy', pattern: "*fq"

    input:
    tuple val(sampleName), path(amplicon_fasta)
    

    output:
    tuple val(sampleName), path("*fq")


    script:
    """


    art_illumina -1 ${params.model_R1} -2 ${params.model_R2} -i ${amplicon_fasta} -f ${params.depth} -l 150 -p -m ${params.fragment_mean} -s ${params.fragment_sd} -o ${amplicon_fasta}_R
  

    
    
    """

}



process runARTVariableDepths {

    tag {sampleName}

    cpus 8

    publishDir "${params.outdir}/amplicon_fastqs/${amplicon_fasta}", mode: 'copy', pattern: "*fq"

    input:
    tuple val(sampleName), path(amplicon_fasta)

    

    output:
    tuple val(sampleName), path("*fq")


    script:
    """


    vary_amp_depths.py --fasta ${amplicon_fasta} --depths ${params.amplicon_depths} --R1 ${params.model_R1} --R2 ${params.model_R2} --l ${params.read_length} --m ${params.fragment_mean} --s ${params.fragment_sd}
  

    
    
    """

}


