process covid_wastewater {
    tag { "Processing ${params.input} with sars-cov-2-wastewater for ${name}" }

    publishDir "${params.outdir}/${name}/SARS-COV-2_WASTEWATER/TOOLS/", mode: 'copy', pattern: "*.yml"
    publishDir "${params.outdir}/${name}/SARS-COV-2_WASTEWATER/DAG", mode: 'copy', pattern: "*.svg"
    publishDir "${params.outdir}/${name}/SARS-COV-2_WASTEWATER/TIPS", mode: 'copy', pattern: "*.md"
    publishDir "${params.outdir}/${name}/SARS-COV-2_WASTEWATER/METADATA", mode: 'copy', pattern: "*.csv"
    publishDir "${params.outdir}/${name}/SARS-COV-2_WASTEWATER/LOGS", mode: 'copy', pattern: "*.log"

    input:
    tuple path(input_file), val(name)

    output:

    tuple path(input_file), val(name), emit: connector
    tuple path("*.yml"), path("*.svg"), path("*.md"), path("*.csv"), emit: output
    path("*.log"), emit: log

    script:
    """

    cp ${projectDir}/resources/pathogen_workflow_dags/sars-cov-2_wastewater_WasteFlow_workflow.svg ./
    cp ${projectDir}/resources/pathogen_tools/sars-cov-2-wastewater_tools.yml ./
    cp ${projectDir}/resources/pathogen_tips/sars-cov-2-wastewater_tips.md ./
    cp ${projectDir}/resources/pathogen_metadata/sars-cov-2-wastewater_metadata.csv ./

    

    # maybe move this to diff module and collect for all processes run by individual:
    current_time=\$(date +%Y%m%d-%H%M%S) > \${current_time}_sars-cov-2-wastewater_wgs.log
    echo -e "Analysis start time: \${current_time}\n
    Pipeline: bioinflow\n
    Module: SARS-CoV-2 Wastewater WGS\n
    User: ${name}" >> \${current_time}_sars-cov-2-wastewater_wgs.log
  
    
    """
}