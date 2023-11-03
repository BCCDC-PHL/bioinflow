import argparse
import os
from Bio import SeqIO

def convert_bed_to_multi_fasta(bed_file, reference_directory, output_directory):
    amplicon_positions = {}

    # Read amplicon positions from the bed file
    with open(bed_file, "r") as f:
        for line in f:
            parts = line.strip().split()
            if len(parts) == 6:
                chrom, start, end, name, primer_pool, strand = parts

                amplicon_number = name.split("_")[-2]
                position_key = f"amplicon{amplicon_number}"

                if position_key not in amplicon_positions:
                    amplicon_positions[position_key] = {"start": None, "end": None}

                if "LEFT" in name:
                    amplicon_positions[position_key]["start"] = int(start)
                elif "RIGHT" in name:
                    amplicon_positions[position_key]["end"] = int(end)

    # Create the output directory if it doesn't exist
    os.makedirs(output_directory, exist_ok=True)

    # Process each reference FASTA file
    for reference_file in os.listdir(reference_directory):
        if reference_file.endswith(".fasta") or reference_file.endswith(".fa"):
            reference_path = os.path.join(reference_directory, reference_file)
            reference_name, _ = os.path.splitext(os.path.basename(reference_file))
            output_file = os.path.join(output_directory, f"{reference_name}_amplicon.fasta")

            with open(output_file, "w") as output:
                for record in SeqIO.parse(reference_path, "fasta"):
                    for amplicon_number, positions in amplicon_positions.items():
                        start = positions["start"]
                        end = positions["end"]
                        if start is not None and end is not None:
                            amplicon_sequence = record.seq[start - 1 : end]
                            amplicon_record = f">{amplicon_number}\n{amplicon_sequence}\n"
                            output.write(amplicon_record)

def main(args):
    convert_bed_to_multi_fasta(args.bed_file, args.reference_directory, args.output_directory)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert a BED file to multi-FASTA files for a directory of reference FASTA files")
    parser.add_argument("--bed_file", required=True, help="Input BED file")
    parser.add_argument("--reference_directory", required=True, help="Path to the directory containing reference FASTA files")
    parser.add_argument("--output_directory", required=True, help="Path to the output directory for multi-FASTA files")
    args = parser.parse_args()

    main(args)
