process collect_question {

    input:
    path(question_file)

    script:
    """
    
    echo -e '${params.name} email: ${params.email}\n ${params.name} question: ${params.question}' >> ${question_file}
     
    """
}

