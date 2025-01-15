process <PATHOGEN> {
    tag { <PATHOGEN> }

    publishDir "${params.outdir}/TOOLS", mode: 'copy', pattern: "*<OUTPUT_FILE>"
    publishDir "${params.outdir}/DAG", mode: 'copy', pattern: "*<OUTPUT_FILE>"
    publishDir "${params.outdir}/TIPS", mode: 'copy', pattern: "*<OUTPUT_FILE>"
    publishDir "${params.outdir}/METADATA_OR_OVERVIEW", mode: 'copy', pattern: "*<OUTPUT_FILE>"
    
    cpus 1

    

    input:
    tuple val(PATHOGEN)

    output:

    tuple val(PATHOGEN), path("*<OUTPUT_FILE>")

    script:

    """
    
    
    """


}




