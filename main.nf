#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// include modules
include {printHelp} from './modules/help.nf'

// import subworkflows
include {AMPulator} from './modules/AMPulator.nf'

if (params.help){
    printHelp()
    exit 0
}

if (params.profile){
    println("Profile should have a single dash: -profile")
    System.exit(1)
}

if ( !params.directory ) {
  println("Please supply a directory containing fastqs or CRAMs with --directory.")
  println("Use --help to print help")
  System.exit(1)
}

if ( (params.bed && ! params.ref) || (!params.bed && params.ref) ) {
  println("--bed and --ref must be supplied together")
  System.exit(1)
}


if ( ! params.prefix ) {
     println("Please supply a prefix for your output files with --prefix")
     println("Use --help to print help")
     System.exit(1)
} else {
     if ( params.prefix =~ /\// ){
         println("The --prefix that you supplied contains a \"/\", please replace it with another character")
         System.exit(1)
     }
} 



// main workflow
workflow {



  main:
    AMPulator()
     
}
