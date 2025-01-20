#!/usr/bin/env python3
import random
import argparse

# filename as input
parser = argparse.ArgumentParser(description="Randomly display an ASCII art piece from a specified file.")
parser.add_argument("file", type=str, help="Path to the file containing ASCII art pieces.")
args = parser.parse_args()

# Create a list to store ASCII art pieces
ascii_gallery = []

# Read the ASCII art file and process the pieces
with open(args.file, "r") as file:
    current_art = ""
    for line in file:
        if line.strip() == "art:":  # Check for the separator
            if current_art:
                ascii_gallery.append(current_art)
            current_art = ""
        else:
            current_art += line

# Add art to gallery
if current_art:
    ascii_gallery.append(current_art)

# Randomly select an ASCII art
random_art = random.choice(ascii_gallery)

# Print the selected ASCII art
print(random_art)