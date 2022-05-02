process H5AD_OUTPUT {
    tag "$meta.id"
    label 'process_low'

    input:
    tuple val(meta), path(count)

    output:
    tuple val(meta), path("**/*.h5ad"), emit: h5ad

    script:
    """
    """
}