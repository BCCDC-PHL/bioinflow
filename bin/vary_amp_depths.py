import os
import csv
import subprocess
import argparse

def main(args):
    # Read the CSV file and create a dictionary of amplicon depths
    amplicon_depths = {}
    with open(args.depths, 'r') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        for row in csv_reader:
            amplicon_id = row['amplicon']
            depth = int(row['depth'])
            amplicon_depths[amplicon_id] = depth

    # Create a directory to store individual FASTA files
    output_directory = 'output_fastas'
    os.makedirs(output_directory, exist_ok=True)

    # Read the original multi-FASTA file and split it into individual FASTA files
    with open(args.fasta, 'r') as fasta_file:
        current_amplicon = None
        current_lines = []

        for line in fasta_file:
            if line.startswith('>'):
                if current_amplicon:
                    amplicon_id = current_amplicon[1:]
                    output_file = os.path.join(output_directory, f'amplicon{amplicon_id}.fasta')
                    with open(output_file, 'w') as output_fasta:
                        output_fasta.writelines(current_lines)
                    current_lines = []

                current_amplicon = line.strip()
            current_lines.append(line)

    # Run a subprocess command for each individual FASTA file
    for amplicon_id, depth in amplicon_depths.items():
        input_fasta = os.path.join(output_directory, f'amplicon{amplicon_id}.fasta')
        subprocess_command = f'echo "command  --fasta {input_fasta} --depth {depth}" '
        subprocess.run(subprocess_command, shell=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process amplicons with specified depths")
    parser.add_argument('--fasta', required=True, help="Path to the input multi-FASTA file")
    parser.add_argument('--depths', required=True, help="Path to the amplicon depths CSV file")
    parser.add_argument('-1, required=True, help="Error model for R1")           
    parser.add_argument('-2, required=True, help="Error model for R2") 
                        
    
    args = parser.parse_args()
    main(args)

