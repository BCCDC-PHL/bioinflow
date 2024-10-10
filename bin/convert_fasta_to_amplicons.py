#!/usr/bin/env python3
import argparse
from Bio import SeqIO
import os

def convert_bed_to_multi_fasta(bed_file, fasta_file):
    amplicon_positions = {}

    # Read amplicon positions from the bed file
    with open(bed_file, "r") as f:
        for line in f:
            parts = line.strip().split()
            if len(parts) == 6:
                chrom, start, end, name, primer_pool, strand = parts
            #if len(parts) == 7:
             #   chrom, start, end, name, primer_pool, strand, primer_seqs = parts

                amplicon_number = name.split("_")[-2]
                position_key = f"amplicon{amplicon_number}"

                if position_key not in amplicon_positions:
                    amplicon_positions[position_key] = {"start": None, "end": None}

                if "LEFT" in name:
                    amplicon_positions[position_key]["start"] = int(start)
                elif "RIGHT" in name:
                    amplicon_positions[position_key]["end"] = int(end)

    fasta_base_name = os.path.splitext(os.path.basename(fasta_file))[0]
    output_file = f"{fasta_base_name}_amplicon.fasta"


    with open(output_file, "w") as output:
        for record in SeqIO.parse(fasta_file, "fasta"):
            for amplicon_number, positions in amplicon_positions.items():
                start = positions["start"]
                end = positions["end"]
                if start is not None and end is not None:
                    amplicon_sequence = record.seq[start : end]
                    amplicon_record = f">{amplicon_number}\n{amplicon_sequence}\n"
                    output.write(amplicon_record)

def main(args):
    convert_bed_to_multi_fasta(args.bed_file, args.fasta_file)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert a BED file to multi-FASTA file using a reference FASTA file")
    parser.add_argument("--bed_file", required=True, help="Input BED file")
    parser.add_argument("--fasta_file", required=True, help="Path to the input FASTA file")

    args = parser.parse_args()

    main(args)
