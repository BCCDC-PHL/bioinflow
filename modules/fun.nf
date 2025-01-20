process generateAsciiArt {
    output:
    stdout

    script:
    """
    ascii_art.py ${projectDir}/resources/ascii_art/art-gallery.txt
     
    """
}

