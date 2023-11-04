#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// include modules
include {printHelp} from './modules/help.nf'

// import subworkflows
include {convertFastaToAmplicons} from './modules/AMPulator.nf'
include {runART} from './modules/AMPulator.nf'


if (params.help){
    printHelp()
    exit 0
}

if (params.profile){
    println("Profile should have a single dash: -profile")
    System.exit(1)
}


ch_bedFile = Channel.fromPath(params.bed)
ch_refDir = Channel.fromPath(params.ref_dir)
ch_modelR1 = Channel.fromPath(params.model_R1)
ch_modelR2 = Channel.fromPath(params.model_R2)
ch_depth = params.depth
ch_fragmentMean = params.fragment_mean
ch_fragmentSD = params.fragment_sd






// main workflow
workflow {



  main:
    convertFastaToAmplicons(ch_bedFile, ch_refDir)
    amplicon_fasta_list = convertFastaToAmplicons.out.amplicon_fastas.collect()
    amplicon_fasta_list.map { amplicon_fasta ->
     runART(amplicon_fasta, ch_bedFile, ch_modelR1, ch_modelR2, ch_depth, ch_fragmentMean, ch_fragmentSD)
    }
    




}

   
    
