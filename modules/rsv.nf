process RSV {
    tag { "Processing ${params.input} with respiratory syncytial virus for ${name}" }

    publishDir "${params.outdir}/${name}/RSV/TOOLS/", mode: 'copy', pattern: "*.yml"
    publishDir "${params.outdir}/${name}/RSV/DAG", mode: 'copy', pattern: "*.svg"
    publishDir "${params.outdir}/${name}/RSV/TIPS", mode: 'copy', pattern: "*.md"
    publishDir "${params.outdir}/${name}/RSV/METADATA", mode: 'copy', pattern: "*.csv"
    publishDir "${params.outdir}/${name}/RSV/LOGS", mode: 'copy', pattern: "*.log"

    input:
    tuple path(input_file), val(name)

    output:

    tuple path(input_file), val(name), emit: connector
    tuple path("*.yml"), path("*.svg"), path("*.md"), path("*.csv"), emit: output
    path("*.log"), emit: log

    script:
    """

    cp ${projectDir}/resources/pathogen_workflow_dags/rsv-dag.svg ./
    cp ${projectDir}/resources/pathogen_tools/rsv_tools.yml ./
    cp ${projectDir}/resources/pathogen_tips/rsv_tips.md ./
    cp ${projectDir}/resources/pathogen_metadata/rsv_metadata.csv ./

    

    # maybe move this to diff module and collect for all processes run by individual:
    current_time=\$(date +%Y%m%d-%H%M%S) > \${current_time}_rsv_ngs.log
    echo -e "This is a test.
    User: ${name}" >> \${current_time}_rsv_ngs.log
  
    
    """
}