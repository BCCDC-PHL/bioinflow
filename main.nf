#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// include modules
include {printHelp} from './modules/help.nf'

// import subworkflows
include {convertFastaToAmplicons} from './modules/AMPulator.nf'
include {runART} from './modules/AMPulator.nf'
include {AMPulator} from './modules/AMPulator.nf'


if (params.help){
    printHelp()
    exit 0
}

if (params.profile){
    println("Profile should have a single dash: -profile")
    System.exit(1)
}


ch_bedFile = Channel.fromPath(params.bed)
ch_refDir = Channel.fromPath(params.ref_dir_string).map{ tuple( it.baseName.split("\\.")[0], it) }




// main workflow
workflow {



  main:
    AMPulator()
    convertFastaToAmplicons(ch_refDir).view() | runART
 


}

   
    
