#!/usr/bin/env nextflow

nextflow.enable.dsl = 2


// function and log info code obtained from BCCDC-PHL/covflo by Jessica Caleta
def header() {

return """

██████╗░██╗░█████╗░██╗███╗░░██╗███████╗██╗░░░░░░█████╗░░██╗░░░░░░░██╗
██╔══██╗██║██╔══██╗██║████╗░██║██╔════╝██║░░░░░██╔══██╗░██║░░██╗░░██║
██████╦╝██║██║░░██║██║██╔██╗██║█████╗░░██║░░░░░██║░░██║░╚██╗████╗██╔╝
██╔══██╗██║██║░░██║██║██║╚████║██╔══╝░░██║░░░░░██║░░██║░░████╔═████║░
██████╦╝██║╚█████╔╝██║██║░╚███║██║░░░░░███████╗╚█████╔╝░░╚██╔╝░╚██╔╝░
╚═════╝░╚═╝░╚════╝░╚═╝╚═╝░░╚══╝╚═╝░░░░░╚══════╝░╚════╝░░░░╚═╝░░░╚═╝░░
output directory: ${params.outdir}
workflow: 


"""
}



/**
---------------------------------------------------------------------------------
program introduction
---------------------------------------------------------------------------------
*/

// this prints program header with mandatory input and output locations
log.info header()

// include modules
include {printHelp} from './modules/help.nf'

// import subworkflows
include {convertFastaToAmplicons} from './modules/amplicone.nf'
include {runART} from './modules/amplicone.nf'
include {runARTVariableDepths} from './modules/amplicone.nf'



if (params.help){
    printHelp()
    exit 0
}

if (params.profile){
    println("Profile should have a single dash: -profile")
    System.exit(1)
}


ch_bedFile = Channel.fromPath(params.bed)
ch_fastaDir = Channel.fromPath(params.fasta_dir_string).map{ tuple( it.baseName.split("\\.")[0], it) }
ch_ampDepths = Channel.fromPath(params.amplicon_depths)







// main workflow
workflow {



  main:

    if (params.vary_amplicon_depths) {

    convertFastaToAmplicons(ch_fastaDir) | runARTVariableDepths

    }
    else {
    convertFastaToAmplicons(ch_fastaDir) | runART
    
    }

    
 


}

   
    
