process covid_clin {
    tag { "Processing ${params.input} with SARS-CoV-2 (clinical) for ${name}" }

    publishDir "${params.outdir}/${name}/SARS-CoV-2_CLINICAL/TOOLS/", mode: 'copy', pattern: "*.yml"
    publishDir "${params.outdir}/${name}/SARS-CoV-2_CLINICAL/DAG", mode: 'copy', pattern: "*.svg"
    publishDir "${params.outdir}/${name}/SARS-CoV-2_CLINICAL/TIPS", mode: 'copy', pattern: "*.md"
    publishDir "${params.outdir}/${name}/SARS-CoV-2_CLINICAL/METADATA", mode: 'copy', pattern: "*.csv"
    publishDir "${params.outdir}/${name}/SARS-CoV-2_CLINICAL/LOGS", mode: 'copy', pattern: "*.log"

    input:
    tuple path(input_file), val(name)

    output:

    tuple path(input_file), val(name), emit: connector
    tuple path("*.yml"), path("*.svg"), path("*.md"), path("*.csv"), emit: output
    path("*.log"), emit: log

    script:
    """

    cp ${projectDir}/resources/pathogen_workflow_dags/sars-cov-2-clinical.svg ./
    cp ${projectDir}/resources/pathogen_tools/sars-cov-2-clinical_tools.yml ./
    cp ${projectDir}/resources/pathogen_tips/sars-cov-2-clinical_tips.md ./
    cp ${projectDir}/resources/pathogen_metadata/sars-cov-2-clinical_metadata.csv ./

    

    # maybe move this to diff module and collect for all processes run by individual:
    current_time=\$(date +%Y%m%d-%H%M%S) > \${current_time}_sars-cov-2-clinical_wgs.log
    echo -e "This is a test.
    User: ${name}" >> \${current_time}_sars-cov-2-clinical_wgs.log
  
    
    """
}