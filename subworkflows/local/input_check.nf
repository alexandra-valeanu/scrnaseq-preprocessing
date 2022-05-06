//
// Check input samplesheet and get read channels
//

include { SAMPLESHEET_CHECK } from '../../modules/local/samplesheet_check'

workflow INPUT_CHECK {
    take:
    samplesheet // file: /path/to/samplesheet.csv

    main:
    SAMPLESHEET_CHECK ( samplesheet )
        .csv
        .splitCsv ( header:true, sep:',' )
        .map { params.input_type=='fastq' ? create_fastq_channel(it) : create_bam_channel(it)}
        .set { reads }

    emit:
    reads                                     // channel: [ val(meta), [ reads ] ]
    versions = SAMPLESHEET_CHECK.out.versions // channel: [ versions.yml ]
}

// Function to get list of [ meta, [ fastq_1, fastq_2 ] ]
def create_fastq_channel(LinkedHashMap row) {
    // create meta map
    def meta = [:]
    meta.id         = row.sample

    // add path(s) of the fastq file(s) to the meta map
    def fastq_meta = []
    if (!file(row.fastq_1).exists() && !file(row.fastq_2).exists()) {
        exit 1, "ERROR: Please check input samplesheet -> Read 1 and Read 2 FastQ files do not exist!\n${row.fastq_1}\n${row.fastq_2}"
    }
    if (row.fastq_3.isEmpty()) {
        fastq_meta = [ meta, [ file(row.fastq_1), file(row.fastq_2) ] ]
    } else {
        if (!file(row.fastq_3).exists()) {
            exit 1, "ERROR: Please check input samplesheet -> Read 3 FastQ file does not exist!\n${row.fastq_3}"
        }
        fastq_meta = [ meta, [ file(row.fastq_1), file(row.fastq_2), file(row.fastq_3) ] ]
    }

    return fastq_meta
}

// Function to get list of [ meta, [ bam ] ]
def create_bam_channel(LinkedHashMap row) {
    // create meta map
    def meta = [:]
    meta.id         = row.sample

    // add path(s) of the fastq file(s) to the meta map
    def fastq_meta = []
    if (!file(row.bam).exists()) {
        exit 1, "ERROR: Please check input samplesheet -> BAM file does not exist!\n${row.bam}"
    }

    bam_meta = [ meta, [ file(row.bam) ] ]

    return bam_meta
}
