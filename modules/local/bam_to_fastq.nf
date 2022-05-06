process BAM_TO_FASTQ {
    // maxRetries 10
    // maxForks 2
    tag "$meta.id"
	label 'bamtofastq'

    input:
    tuple val(meta), path(reads)

	output:
	tuple val(meta), path("${meta.id}_{1,2,3}.fastq.gz"), emit: reads

    script:
    """
    bamtofastq_linux --nthreads=42 --reads-per-fastq=50000000000 ${reads} ${meta.id}/

    rename_fastq.py ${meta.id}

    """
}
