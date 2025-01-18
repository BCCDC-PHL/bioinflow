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
include {influenza} from './modules/flu.nf'
include {rsv} from './modules/rsv.nf'
include {tb} from './modules/tb.nf'


if (params.help){
    printHelp()
    exit 0
}

/**
if (params.profile){
    println("Profile should have a single dash: -profile")
    System.exit(1)
}
*/


workflow {

    in_ch = Channel.fromPath(params.input)
    who_ch = Channel.of(params.name)

  main:

    if (params.input == "NO_FILE") {
        error "ERROR: Missing mandatory input file. Specify with --input parameter."
    } 

    if (!params.name) {
        error "ERROR: Missing mandatory input value. Who is this? Specify with --name parameter."
    } 
    
    influenza(in_ch.combine(who_ch))
    rsv(in_ch.combine(who_ch))
    tb(in_ch.combine(who_ch))


}





   
    
