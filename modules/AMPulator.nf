process convertFastaToAmplicons {
    tag { sampleName }

    publishDir "${params.outdir}/amplicon_fastas", mode: 'copy', pattern: "*amplicon.fasta"
    
    cpus 1

    input:
    tuple val(sampleID), path(fasta)

    output:

    tuple val(sampleID), path('*amplicon.fasta')

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
    tuple val(sampleID),path(amplicon_fasta)
    

    output:
    tuple val(sampleID), path("*fq")


    script:
    """


    art_illumina -1 ${params.model_R1} -2 ${params.model_R2} -i ${amplicon_fasta} -f ${params.depth} -l 150 -p -m ${params.fragment_mean} -s ${params.fragment_sd} -o ${amplicon_fasta}_R
  

    
    
    """

}


