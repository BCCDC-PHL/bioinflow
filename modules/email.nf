process sendEmail {

    output:
    stdout

    script:
    """
    #!/bin/bash
    
    echo "Thank you for running bioinflow! You will receive your results via email within a minute or two."
    sleep 5

    cd ${projectDir}/results
    zip -r ${params.name}_bioinflow_results.zip ${params.name} > zip.log

    (
  echo "From: ${params.email}"
  echo "To: ${params.email}"
  echo "Subject: Bioinflow Results"
  echo "MIME-Version: 1.0"
  echo "Content-Type: multipart/mixed; boundary=frontier"
  echo ""
  echo "--frontier"
  echo "Content-Type: text/html; charset=UTF-8"
  echo ""
  echo "Hello!<br><br> "
  echo ""
  echo "Attached are your Bioinflow results.<br><br> "
  echo ""
  echo "If you enjoyed using bioinflow, please check out https://github.com/BCCDC-PHL/bioinflow and give us a star!<br><br>"
  echo ""
  echo "Best,<br>"
  echo ""
  echo "Tara & Jess"
  echo "--frontier"
  echo "Content-Type: application/zip"
  echo "Content-Disposition: attachment; filename=${params.name}_bioinflow_results.zip"
  echo "Content-Transfer-Encoding: base64"
  echo ""
  base64 ${params.name}_bioinflow_results.zip  # Encode the zip file in base64
  echo ""
  echo "--frontier--"
) | /usr/sbin/sendmail -t

    rm zip.log ${params.name}_bioinflow_results.zip


     
    """
}

