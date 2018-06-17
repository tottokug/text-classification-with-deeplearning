#!/bin/bash
PROJECT_HOME=$(cd $(dirname $0); cd ../../; pwd)
INPUT_DIR=${PROJECT_HOME}/Data/Processed/01_Unziped
OUTPUT_DIR=${PROJECT_HOME}/Data/Processed/02_UTF-8

[ -e "${OUTPUT_DIR}" ] || mkdir ${OUTPUT_DIR}
rm -rf ${OUTPUT_DIR}/*

cp -r ${INPUT_DIR}/* ${OUTPUT_DIR}/


find ${OUTPUT_DIR} -type f -exec nkf -w --overwrite {} \;
