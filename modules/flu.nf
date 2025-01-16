process influenza {
    tag { "Processing ${params.input} with influenza for ${name}" }

    publishDir "${params.outdir}/${name}/FLU/TOOLS/", mode: 'copy', pattern: "*.yml"
    publishDir "${params.outdir}/${name}/FLU/DAG", mode: 'copy', pattern: "*.svg"
    publishDir "${params.outdir}/${name}/FLU/TIPS", mode: 'copy', pattern: "*.md"
    publishDir "${params.outdir}/${name}/FLU/METADATA", mode: 'copy', pattern: "*.csv"
    publishDir "${params.outdir}/${name}/FLU/LOGS", mode: 'copy', pattern: "*.log"

    cpus 1

    input:
    tuple val(name), path(input_file), val(PATHOGEN)

    output:

    tuple val(PATHOGEN), path("*.txt"), emit: connector
    path("*.yml"), path("*.svg"), path("*.md"), path("*.csv"), emit: output
    path("*.log"), emit: log

    script:
    """
    #either generate in process - maybe if want some runtime-specific info, otherwise can copy file from resources instead
    printf -- "- pathogen: influenza\\n" > influenza_wgs_software.yml
    printf -- "  tool_name: cutadapt\\n  tool_version: \\n  tool_function: \\n" >> influenza_wgs_software.yml


    cp ${workflow.projectDir}/resources/pathogen_workflow_dags/influenza_fluviewer-nf_workflow.svg ./?

    printf -- "# Likely the goal of sequencing influenza will be to type .." >> influenza_wgs_tips.md

    # maybe move this to diff module and collect for all processes run by individual:
    current_time=\$(date +%Y%m%d-%H%M%S)
    echo \$(freyja demix --version) > \${current_time}_influenza_wgs.log
    echo -e "Pipeline name: ${workflow.manifest.name}  
    Pipeline version: ${workflow.manifest.version}  
    Nextflow version: ${nextflow.version}  
    Execution start time: ${workflow.start}
    Executed command: ${workflow.commandLine} 
    Data directory: ${params.data_dir}
    Results directory: ${params.out_dir}
    Project directory: ${workflow.projectDir}
    Launch directory: ${workflow.launchDir} 
    Session ID: ${workflow.sessionId} " >> \${current_time}_influenza_wgs.log

    
    """


}