def printHelp() {
  log.info"""
  Usage:
    nextflow run BCCDC-PHL/bioinflow --name <NAME> --input </path/correct/input/file> [OPTIONS]

  Description:
    <Insert description>

    All options set via CLI can be set in conf directory

  Nextflow arguments (single DASH):
    -resume                       Pick up analysis where you left off  
 
  Workflow options:
    Mandatory:
    --input                       Absolute path to the input file.  
    --name                        Name of user. Used for logging and output directory.

    Optional:
      --resp                      Retrieve information about respiratory pathogen analyses (flu, rsv, tb, sars-cov-2) 
      --virus                     Retrieve information about viral genomic analyses (flu, rsv, sars-cov-2) 
      --bact                      Retrieve information about bacterial genomic analyses (tb, tpa) 
      --pathogen                  Retrieve information about single pathogen of interest [flu,rsv,tb,sarscov2_ww,sarscov2_clin,tpa]
      --all                       Retrieve information about all pathogen analyses (flu, rsv, tb, sars-cov-2, tpa)
      --email                     Enter your email to receive your results
      --question                  Ask us a question. Ensure you use the --email parameter so we can get back to you
      --fun                       Have a little fun


  """.stripIndent()
}