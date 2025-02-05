#!/usr/bin/env nextflow

nextflow.enable.dsl = 2


def header() {

return """

██████╗░██╗░█████╗░██╗███╗░░██╗███████╗██╗░░░░░░█████╗░░██╗░░░░░░░██╗
██╔══██╗██║██╔══██╗██║████╗░██║██╔════╝██║░░░░░██╔══██╗░██║░░██╗░░██║
██████╦╝██║██║░░██║██║██╔██╗██║█████╗░░██║░░░░░██║░░██║░╚██╗████╗██╔╝
██╔══██╗██║██║░░██║██║██║╚████║██╔══╝░░██║░░░░░██║░░██║░░████╔═████║░
██████╦╝██║╚█████╔╝██║██║░╚███║██║░░░░░███████╗╚█████╔╝░░╚██╔╝░╚██╔╝░
╚═════╝░╚═╝░╚════╝░╚═╝╚═╝░░╚══╝╚═╝░░░░░╚══════╝░╚════╝░░░░╚═╝░░░╚═╝░░
output directory: ${params.outdir}
user: ${params.name}
input: ${params.input} 


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
include {covid_wastewater} from './modules/sars-cov-2-wastewater.nf'
include {covid_clinical} from './modules/sars-cov-2-clinical.nf'
include {syphilis} from './modules/tpa.nf'
include {generateAsciiArt} from './modules/fun.nf'
include {sendEmail} from './modules/email.nf'


if (params.help){
    printHelp()
    exit 0
}


workflow {

    in_txt_ch = Channel.fromPath(params.input)
    .filter { it.name.endsWith('.txt') }

    in_md_ch = Channel.fromPath(params.input)
    .filter { it.name.endsWith('.md') }

    in_ch = in_txt_ch.concat(in_md_ch)

    who_ch = Channel.of(params.name)

  main:

    if (params.input == "NO_FILE") {
        error "ERROR: Missing mandatory input file. Specify with --input parameter."
    } 

    if (!params.name) {
        error "ERROR: Missing mandatory input value. Who is this? Specify with --name parameter."
    } 

    if (params.pathogen == "flu") {
        influenza(in_txt_ch.combine(who_ch))
    } 
    else if (params.pathogen == "rsv") {
        rsv(in_md_ch.combine(who_ch))
    }
    else if (params.pathogen == "tb") {
        tb(in_txt_ch.combine(who_ch))
    }
    else if (params.pathogen == "sarscov2_ww") {
        covid_wastewater(in_md_ch.combine(who_ch))
    }
    else if (params.pathogen == "sarscov2_clin") {
        covid_clinical(in_md_ch.combine(who_ch))
    }
    else if (params.pathogen == "tpa") {
        syphilis(in_txt_ch.combine(who_ch))
    }
    else {
        error "ERROR: This pathogen does not exist. Check spelling or docs for valid options."
    }
    

    if (params.all) {
        influenza(in_ch.combine(who_ch))
        rsv(in_ch.combine(who_ch))
        tb(in_ch.combine(who_ch))
        covid_wastewater(in_ch.combine(who_ch))
        covid_clinical(in_ch.combine(who_ch))
        syphilis(in_ch.combine(who_ch))
    }
    else if (params.resp) {
        influenza(in_ch.combine(who_ch))
        rsv(in_ch.combine(who_ch))
        tb(in_ch.combine(who_ch))
        covid_wastewater(in_ch.combine(who_ch))
        covid_clinical(in_ch.combine(who_ch))
    }
    else if (params.virus) {
        influenza(in_ch.combine(who_ch))
        rsv(in_ch.combine(who_ch))
        covid_wastewater(in_ch.combine(who_ch))
        covid_clinical(in_ch.combine(who_ch))
    }
    else if (params.bact) {
        tb(in_ch.combine(who_ch))
        syphilis(in_ch.combine(who_ch))
    }


    if (params.fun) {
        generateAsciiArt() | view 
    }


    if (params.question != "NO QUESTION INPUT") {


    }    


}


