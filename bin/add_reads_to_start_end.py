#!/usr/bin/env python3
# Script obtained from John Palmer 
import os, sys, pandas as pd 
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord
from Bio.Seq import Seq
import gzip
import copy 
import argparse

def extract_end_sequences(fasta_file, length):
    start_reads = []
    end_reads = []

    for r in SeqIO.parse(fasta_file, 'fasta'):
        record1 = copy.deepcopy(r)
        record2 = copy.deepcopy(r)
     
        record1.seq = record1.seq[0:length]
        start_reads += [record1]

        record2.seq = record2.seq[-length:]
        end_reads += [record2]
  
    return start_reads, end_reads
    
def reverse_complement(record):
    # Create a new SeqRecord with the reversed sequence and copy over the ID, name, and description
    reversed_record = SeqRecord(record.seq.reverse_complement(), id=record.id, name=record.name, description=record.description)
    
    # If there are per-letter annotations (like quality scores), reverse them as well
    if record.letter_annotations:
        for key, value in record.letter_annotations.items():
            reversed_record.letter_annotations[key] = value[::-1]
            
    return reversed_record

def generate_reads(sequences, depth, reverse=False):
    # Assuming you want to generate overlapping reads to cover the entire region
    suffix = '/1' if not reverse else "/2"

    for s in sequences:
        
        id = s.id

        for i in range(0, depth*2, 2):
            sequence = copy.deepcopy(s)
            sequence.id = id + "-X" + str(i) + suffix 
            sequence.seq = sequence.seq if not reverse else sequence.seq.reverse_complement()
            sequence.name = sequence.id
            sequence.description = ""
            sequence.letter_annotations = {"phred_quality": [35]*len(sequence.seq)}
            
            yield sequence

def write_reads_to_fastq(read_generator, fastq_file, reverse=False):
    if fastq_file.endswith('.gz'):
        with gzip.open(fastq_file, 'at') as outfile:
            SeqIO.write(read_generator, outfile, "fastq")
    else:
        with open(fastq_file, 'a') as outfile:
            SeqIO.write(read_generator, outfile, "fastq")

def main(args):
   
    start_seqs, end_seqs = extract_end_sequences(args.fasta, args.end_length)

    write_reads_to_fastq(generate_reads(start_seqs, args.depth), args.r1)
    write_reads_to_fastq(generate_reads(start_seqs, args.depth, reverse=True), args.r2)

    write_reads_to_fastq(generate_reads(end_seqs, args.depth), args.r1)  
    write_reads_to_fastq(generate_reads(end_seqs, args.depth, reverse=True), args.r2)  

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--fasta', type=argparse.FileType('r'), required=True, help="Path to the input multi-FASTA file")
    parser.add_argument('--r1', required=True, help="R1 of ART simulated fastq")
    parser.add_argument('--r2', required=True, help="R2 of ART simulated fastq")
    parser.add_argument('--depth', type=int, required=True, help="depth of start and end reads")
    parser.add_argument('--end_length, type=int, default=100, help="length of ends to add extra depth for")
    args = parser.parse_args()
    main(args)
