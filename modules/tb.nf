process tb {
    tag { "Processing ${params.input} with Mycobacterium tuberculosis for ${name}" }

    publishDir "${params.outdir}/${name}/TB/TOOLS/", mode: 'copy', pattern: "*.yml"
    publishDir "${params.outdir}/${name}/TB/DAG", mode: 'copy', pattern: "*.png"
    publishDir "${params.outdir}/${name}/TB/TIPS", mode: 'copy', pattern: "*.md"
    publishDir "${params.outdir}/${name}/TB/METADATA", mode: 'copy', pattern: "*.csv"
    publishDir "${params.outdir}/${name}/TB/LOGS", mode: 'copy', pattern: "*.log"

    input:
    tuple path(input_file), val(name)

    output:

    tuple path(input_file), val(name), emit: connector
    tuple path("*.yml"), path("*.png"), path("*.md"), path("*.csv"), emit: output
    path("*.log"), emit: log

    script:
    """

    cp ${projectDir}/resources/pathogen_workflow_dags/TB_WGS_sequencing_workflow.png ./
    cp ${projectDir}/resources/pathogen_tools/tb_tools.yml ./
    cp ${projectDir}/resources/pathogen_tips/tb_tips.md ./
    cp ${projectDir}/resources/pathogen_metadata/tb_metadata.csv ./

    

    # maybe move this to diff module and collect for all processes run by individual:
    current_time=\$(date +%Y%m%d-%H%M%S) > \${current_time}_tb_wgs.log
    echo -e "This is a test.
    User: ${name}" >> \${current_time}_tb_wgs.log
  
    
    """
}