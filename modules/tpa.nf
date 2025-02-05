process syphilis {
    tag { "Processing ${params.input.baseName} with syphilis for ${name}" }

    publishDir "${params.outdir}/${name}/TREPONEMA_PALLIDUM/TOOLS/", mode: 'copy', pattern: "*.yml"
    publishDir "${params.outdir}/${name}/TREPONEMA_PALLIDUM/DAG", mode: 'copy', pattern: "*.svg"
    publishDir "${params.outdir}/${name}/TREPONEMA_PALLIDUM/TIPS", mode: 'copy', pattern: "*.md"
    publishDir "${params.outdir}/${name}/TREPONEMA_PALLIDUM/METADATA", mode: 'copy', pattern: "*.csv"
    publishDir "${params.outdir}/${name}/TREPONEMA_PALLIDUM/LOGS", mode: 'copy', pattern: "*.log"

    input:
    tuple path(input_file), val(name)

    output:

    tuple path(input_file), val(name), emit: connector
    tuple path("*.yml"), path("*.svg"), path("*.md"), path("*.csv"), emit: output
    path("*.log"), emit: log

    script:
    """

    cp ${projectDir}/resources/pathogen_workflow_dags/tpa_workflow.svg ./
    cp ${projectDir}/resources/pathogen_tools/tpa_tools.yml ./
    cp ${projectDir}/resources/pathogen_tips/tpa_tips.md ./
    cp ${projectDir}/resources/pathogen_metadata/tpa_metadata.csv ./

    

    # maybe move this to diff module and collect for all processes run by individual:
    current_time=\$(date +%Y%m%d-%H%M%S) > \${current_time}_syphilis.log
    echo -e "Analysis start time: \${current_time}\n
    Pipeline: bioinflow\n
    Module: Treponema pallidum\n
    User: ${name}" >> \${current_time}_syphilis.log
  
    
    """
}