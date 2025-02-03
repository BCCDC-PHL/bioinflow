// Welcome to the hidden fun module! If you run bioinflow with the --fun paramter, and ascii art image will appear upon pipeline completion. Note: this is only compatible if you have python available in your base environment.
process generateAsciiArt {
    output:
    stdout

    script:
    """
    ascii_art.py ${projectDir}/resources/ascii_art/art-gallery.txt
     
    """
}

