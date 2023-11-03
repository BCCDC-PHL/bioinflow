def printHelp() {
  log.info"""
  Usage:
    nextflow run BCCDC-PHL/AMPulator -profile conda --prefix [prefix] [workflow-options]

  Description:
    <Insert description>

    All options set via CLI can be set in conf directory

  Nextflow arguments (single DASH):
    -profile                      Allowed values: conda
 
  Workflow options:
    Mandatory:

    Optional:
      --outdir                    Output directory (Default: ./results)

      --schemeVersion             ARTIC scheme version (Default: '[INSERT HERE]')
      --schemeRepoURL             Repo to download your primer scheme from (Default: '[INSERT HERE]')
      --schemeDir                 Directory within schemeRepoURL that contains primer schemes (Default: 'primer_schemes')
      --scheme                    Scheme name (Default: '[INSERT HERE]')
 
      --bed                       Path to primer bed file, also requires 
                                  Overrides --scheme* options. (Default: unset, download scheme from git)


  """.stripIndent()
}