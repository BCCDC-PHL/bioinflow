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
    convert_fasta_to_amplicons.py --bed_file ${params.bed} --fasta_file ${fasta} 
    
    """


}

process runART {

    tag {sampleName}

    cpus 8

    publishDir "${params.outdir}/amplicon_fastqs_depth_${params.depth}", mode: 'copy', pattern: "*fq.gz"

    input:
    tuple val(sampleName), path(amplicon_fasta)
    

    output:
    tuple val(sampleName), path("*fq.gz")


    script:
    """


    art_illumina -1 ${params.model_R1} -2 ${params.model_R2} -i ${amplicon_fasta} -f ${params.depth} -l 150 -p -m ${params.fragment_mean} -s ${params.fragment_sd} -o ${sampleName}_depth_${params.depth}_R

    gzip *.fq
    echo "adding reads at ends"
    add_reads_to_start_end.py --fasta ${amplicon_fasta} --r1 ${sampleName}_depth_${params.depth}_R1.fq.gz --r2 ${sampleName}_depth_${params.depth}_R2.fq.gz --depth ${params.depth} --end_length ${params.end_length}

    
    
    """

}



process runARTVariableDepths {

    tag {sampleName}

    cpus 8

    publishDir "${params.outdir}/amplicon_varied_depths_fastqs/", mode: 'copy', pattern: "*fq.gz"

    input:
    tuple val(sampleName), path(amplicon_fasta)

    

    output:
    tuple val(sampleName), path("*fq.gz")


    script:
    """


    vary_amp_depths.py --fasta ${amplicon_fasta} --depths ${params.amplicon_depths} --R1 ${params.model_R1} --R2 ${params.model_R2} --l ${params.read_length} --m ${params.fragment_mean} --s ${params.fragment_sd} --end_length ${params.end_length}

    cat *R1.fq > ${sampleName}_R1.fq
    cat *R2.fq > ${sampleName}_R2.fq
    gzip *${sampleName}*.fq 

    
    
    """

}


