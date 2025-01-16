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
include {influenza} from './modules/flu.nf'




if (params.help){
    printHelp()
    exit 0
}

if (params.profile){
    println("Profile should have a single dash: -profile")
    System.exit(1)
}


// main workflow
workflow {

    in_ch = Channel.fromPath(params.input)
    who_ch = Channel.value(params.name)

  main:

    if (params.input) == "NO_FILE" {
        error "ERROR: Missing mandatory input file. Specify with --input parameter."
    } 

    if !(params.name) {
        error "ERROR: Missing mandatory input value. Who is this? Specify with --name parameter."
    } 

    if (params.resp) {

        influenza | tb | sarscov2
    }



    if (params.vary_amplicon_depths) {

    convertFastaToAmplicons(ch_fastaDir) | runARTVariableDepths

    }
    else {
    convertFastaToAmplicons(ch_fastaDir) | runART
    
    }

    
 


}

   
    
