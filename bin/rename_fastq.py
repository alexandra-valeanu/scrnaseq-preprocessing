#!/usr/bin/env python

"""Provide a command line tool to validate and transform tabular samplesheets."""

import os
import glob
import sys

metaid = sys.argv[1]

for file in glob.glob(metaid + '/**/*.fastq.gz', recursive=True):
    if 'R1' in file:
        os.rename(file, metaid + '_1.fastq.gz')
    if 'R2' in file:
        os.rename(file, metaid + '_2.fastq.gz')
    if 'R3' in file:
        os.rename(file, metaid + '_3.fastq.gz')
