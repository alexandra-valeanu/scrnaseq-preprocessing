process SAMPLESHEET_CHECK {
    tag "$samplesheet"
    label 'process_low'

    // conda (params.enable_conda ? "conda-forge::python=3.8.3" : null)
    // container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
    //     'https://depot.galaxyproject.org/singularity/python:3.8.3' :
    //     'quay.io/biocontainers/python:3.8.3' }"

    input:
    path samplesheet

    output:
    path '*.csv'       , emit: csv
    path "versions.yml", emit: versions

    script: // This script is bundled with the pipeline, in nf-core/preprocessing/bin/
    if( params.input_type == 'bam' )
        """
        check_samplesheet_bam.py \\
            $samplesheet \\
            samplesheet.valid.csv

        cat <<-END_VERSIONS > versions.yml
        "${task.process}":
            python: \$(python --version | sed 's/Python //g')
        END_VERSIONS
        """

    else if( params.input_type == 'fastq' )
        """
        check_samplesheet.py \\
            $samplesheet \\
            samplesheet.valid.csv

        cat <<-END_VERSIONS > versions.yml
        "${task.process}":
            python: \$(python --version | sed 's/Python //g')
        END_VERSIONS
        """
    else
        error "Invalid input type: ${params.input_type}"
}
