process influenza {
    tag { "Processing ${params.input} with influenza for ${name}" }

    publishDir "${params.outdir}/${name}/FLU/TOOLS/", mode: 'copy', pattern: "*.yml"
    publishDir "${params.outdir}/${name}/FLU/DAG", mode: 'copy', pattern: "*.svg"
    publishDir "${params.outdir}/${name}/FLU/TIPS", mode: 'copy', pattern: "*.md"
    publishDir "${params.outdir}/${name}/FLU/METADATA", mode: 'copy', pattern: "*.csv"
    publishDir "${params.outdir}/${name}/FLU/LOGS", mode: 'copy', pattern: "*.log"

    input:
    tuple path(input_file), val(name)

    output:

    tuple path(input_file), val(name), emit: connector
    tuple path("*.yml"), path("*.svg"), path("*.md"), path("*.csv"), emit: output
    path("*.log"), emit: log

    script:
    """

    cp ${projectDir}/resources/pathogen_workflow_dags/influenza_fluviewer-nf_workflow.svg ./
    cp ${projectDir}/resources/pathogen_tools/influenza_tools.yml ./
    cp ${projectDir}/resources/pathogen_tips/influenza_tips.md ./
    cp ${projectDir}/resources/pathogen_metadata/influenza_metadata.csv ./

    

    # maybe move this to diff module and collect for all processes run by individual:
    current_time=\$(date +%Y%m%d-%H%M%S) > \${current_time}_influenza_wgs.log
    echo -e "This is a test.
    User: ${name}" >> \${current_time}_influenza_wgs.log
  
    
    """
}