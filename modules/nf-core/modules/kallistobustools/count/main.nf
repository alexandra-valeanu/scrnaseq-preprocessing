process KALLISTOBUSTOOLS_COUNT {
    tag "$meta.id"
    label 'process_high'

    // conda (params.enable_conda ? 'bioconda::kb-python=0.26.3' : null)
    // container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
    //     'https://depot.galaxyproject.org/singularity/kb-python:0.26.3--pyhdfd78af_0' :
    //     'quay.io/biocontainers/kb-python:0.26.3--pyhdfd78af_0' }"

    input:
    tuple val(meta), path(reads)
    path  index
    path  t2g
    path  t1c
    path  t2c
    val   workflow_mode
    val   technology

    output:
    tuple val(meta), path ("*.count"), emit: count
    path "versions.yml"              , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    def cdna     = t1c ? "-c1 $t1c" : ''
    def introns  = t2c ? "-c2 $t2c" : ''

    if ( reads.size()==2 ) {
    """
    [ ! -f  ${prefix}_1.fastq.gz ] && ln -s ${reads[0]} ${prefix}_1.fastq.gz
    [ ! -f  ${prefix}_2.fastq.gz ] && ln -s ${reads[1]} ${prefix}_2.fastq.gz 

    kb \\
        count \\
        --h5ad \\
        --verbose \\
        -t $task.cpus \\
        -i $index \\
        -g $t2g \\
        $cdna \\
        $introns \\
        --workflow $workflow_mode \\
        -x $technology \\
        $args \\
        -o ${prefix}.count \\
        ${prefix}_1.fastq.gz \\
        ${prefix}_2.fastq.gz 

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        kallistobustools: \$(echo \$(kb --version 2>&1) | sed 's/^.*kb_python //;s/positional arguments.*\$//')
    END_VERSIONS
    """
    } else if (reads.size()==3) {
    """
    [ ! -f  ${prefix}_1.fastq.gz ] && ln -s ${reads[0]} ${prefix}_1.fastq.gz
    [ ! -f  ${prefix}_2.fastq.gz ] && ln -s ${reads[1]} ${prefix}_2.fastq.gz
    [ ! -f  ${prefix}_3.fastq.gz ] && ln -s ${reads[2]} ${prefix}_3.fastq.gz

    kb \\
        count \\
        --h5ad \\
        --verbose \\
        -t $task.cpus \\
        -i $index \\
        -g $t2g \\
        $cdna \\
        $introns \\
        --workflow $workflow_mode \\
        -x $technology \\
        $args \\
        -o ${prefix}.count \\
        ${prefix}_2.fastq.gz \\
        ${prefix}_3.fastq.gz \\
        ${prefix}_1.fastq.gz

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        kallistobustools: \$(echo \$(kb --version 2>&1) | sed 's/^.*kb_python //;s/positional arguments.*\$//')
    END_VERSIONS
    """    
    }
}
