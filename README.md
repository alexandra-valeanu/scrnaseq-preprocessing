# ![nf-core/preprocessing](docs/images/nf-core/preprocessing_logo_light.png#gh-light-mode-only) ![nf-core/preprocessing](docs/images/nf-core/preprocessing_logo_dark.png#gh-dark-mode-only)

[![GitHub Actions CI Status](https://github.com/nf-core/preprocessing/workflows/nf-core%20CI/badge.svg)](https://github.com/nf-core/preprocessing/actions?query=workflow%3A%22nf-core+CI%22) [![GitHub Actions Linting Status](https://github.com/nf-core/preprocessing/workflows/nf-core%20linting/badge.svg)](https://github.com/nf-core/preprocessing/actions?query=workflow%3A%22nf-core+linting%22) [![AWS CI](https://img.shields.io/badge/CI%20tests-full%20size-FF9900?labelColor=000000&logo=Amazon%20AWS)](https://nf-co.re/preprocessing/results) [![Cite with Zenodo](http://img.shields.io/badge/DOI-10.5281/zenodo.XXXXXXX-1073c8?labelColor=000000)](https://doi.org/10.5281/zenodo.XXXXXXX) [![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A521.10.3-23aa62.svg?labelColor=000000)](https://www.nextflow.io/) [![run with singularity](https://img.shields.io/badge/run%20with-singularity-1d355c.svg?labelColor=000000)](https://sylabs.io/docs/) [![Get help on Slack](http://img.shields.io/badge/slack-nf--core%20%23preprocessing-4A154B?labelColor=000000&logo=slack)](https://nfcore.slack.com/channels/preprocessing)

## Introduction

<!-- TODO nf-core: Write a 1-2 sentence summary of what data the pipeline is for and what it does -->

**nf-core/preprocessing** is a bioinformatics best-practice analysis pipeline for test.

The pipeline is built using [Nextflow](https://www.nextflow.io), a workflow tool to run tasks across multiple compute infrastructures in a very portable manner. It uses Docker/Singularity containers making installation trivial and results highly reproducible. The [Nextflow DSL2](https://www.nextflow.io/docs/latest/dsl2.html) implementation of this pipeline uses one container per process which makes it much easier to maintain and update software dependencies. Where possible, these processes have been submitted to and installed from [nf-core/modules](https://github.com/nf-core/modules) in order to make them available to all nf-core pipelines, and to everyone within the Nextflow community!

<!-- TODO nf-core: Add full-sized test dataset and amend the paragraph below if applicable -->


## Pipeline summary

<!-- TODO nf-core: Fill in short bullet-pointed list of the default steps in the pipeline -->

1. Read QC ([`FastQC`](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/))
2. Present QC for raw reads ([`MultiQC`](http://multiqc.info/))
3. kallisto|bustools counts ([`kb-tools`](https://www.kallistobus.tools/kb_usage/kb_count/))
    - Align reads to a reference transcriptome
    - Correct barcode errors
    - Produce a count matrix 
4. Rename H5AD files with given sample name

## Quick Start

1. Install [`Nextflow`](https://www.nextflow.io/docs/latest/getstarted.html#installation) (`>=21.10.3`)

2. Download the pipeline and test it on a minimal dataset with a single command:

   ```console
   nextflow run nf-core-preprocessing -profile test,singularity --outdir <OUTDIR>
   ```

   Note that some form of configuration will be needed so that Nextflow knows how to fetch the required software. This is usually done in the form of a config profile (`YOURPROFILE` in the example command above). You can chain multiple config profiles in a comma-separated string.

   > - The pipeline comes with config profile called `singularity` which instruct the pipeline to use the named tool for software management. For example, `-profile test,singularity`.

3. Build your own samplesheet.csv like in example of test file:

   https://git.rwth-aachen.de/vleanu.alexandra/test-files/-/raw/main/samplesheet_test.csv

4. Start running your own analysis!

   <!-- TODO nf-core: Update the example "typical command" below used to run the pipeline -->

   ```console
   nextflow run nf-core-preprocessing -profile singularity \
   --input 'path/to/samplesheet.csv' \
   --index 'path/to/index.idx' \
   --t2g '/path/to/t2g.txt' \
   --t1c '/path/to/cdna_t2c.txt' \
   --t2c 'path/to/intron_t2c.txt' \
   --workflow_mode 'lamanno' \
   --technology '10XV3' \
   --outdir '/path/to/dir/to/store/results/' \
   -with-report '/path/to/store/nfcore_report.html' 
   ```

## Credits

nf-core-preprocessing was originally written by Alexandra Valeanu.

We thank the following people for their extensive assistance in the development of this pipeline: Zhambyl Otarbayev

<!-- TODO nf-core: If applicable, make list of people who have also contributed -->

## Citations

<!-- TODO nf-core: Add citation for pipeline after first release. Uncomment lines below and update Zenodo doi and badge at the top of this file. -->
<!-- If you use  nf-core/preprocessing for your analysis, please cite it using the following doi: [10.5281/zenodo.XXXXXX](https://doi.org/10.5281/zenodo.XXXXXX) -->

<!-- TODO nf-core: Add bibliography of tools and data used in your pipeline -->


> **The nf-core framework for community-curated bioinformatics pipelines.**
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> _Nat Biotechnol._ 2020 Feb 13. doi: [10.1038/s41587-020-0439-x](https://dx.doi.org/10.1038/s41587-020-0439-x).
