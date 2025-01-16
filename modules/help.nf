def printHelp() {
  log.info"""
  Usage:
    nextflow run BCCDC-PHL/bioinflow -profile conda --input [path] [OPTIONS]

  Description:
    <Insert description>

    All options set via CLI can be set in conf directory

  Nextflow arguments (single DASH):
    -profile                      Allowed values: conda
    -resume                       Pick up analysis where you left off
 
  Workflow options:
    Mandatory:
    --input                       Absolute path to the input file. 
    --name                        Name of user. Used for logging and output directory.

    Optional:
      --resp                      Retrieve information about respiratory pathogen analyses (flu, rsv, tb, sars-cov-2) 
      --virus                     Retrieve information about viral genomic analyses (flu, rsv, sars-cov-2) 
      --bact                      Retrieve information about bacterial genomic analyses (tb, treponema) 
      --pathogen                  Retrieve information about single pathogen of interest



  """.stripIndent()
}