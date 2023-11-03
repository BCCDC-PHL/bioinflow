import argparse
from Bio import SeqIO

def convert_amplicons(bed_file, output_file):
    amplicon_positions = {}

    with open(bed_file, "r") as f:
        for line in f:
            parts = line.strip().split()
            print(parts)
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


    with open(output_file, "w") as output:
        for record in SeqIO.parse(reference_file, "fasta"):
            for amplicon_name, start, end in amplicon_positions.items():
                if start is not None and end is not None:
                    amplicon_sequence = record.seq[start - 1 : end]
                    amplicon_record = f">{amplicon_name}\n{amplicon_sequence}\n"
                    output.write(amplicon_record)


def main(args):
    convert_amplicons(args.bed_file, args.output_file)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert a BED file to the required amplicon positions format")
    parser.add_argument("--bed_file", help="Input BED file")
    parser.add_argument("output_file", help="Output file for amplicon positions")
    parser.add_argument("--reference-file", required=True, help="Path to the reference FASTA file")
    parser.add_argument("--amplicon-file", required=True, help="Path to the amplicon positions file")
    parser.add_argument("--output-file", required=True, help="Path to the output multi-FASTA file")
    args = parser.parse_args()

    main(args)
