#!/bin/bash
mkdir -p envs/singularity/genericdata
cd envs/singularity/genericdata
singularity pull docker://genericdata/ch-env
