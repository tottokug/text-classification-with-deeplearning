#!/bin/bash
PROJECT_HOME=$(cd $(dirname $0); cd ../../; pwd)
INPUT_DIR=${PROJECT_HOME}/Data/Processed/04_rename
OUTPUT_DIR=${PROJECT_HOME}/Data/Processed/05_merge

[ -e "${OUTPUT_DIR}" ] || mkdir ${OUTPUT_DIR}
IFS='
'

for d in $(ls ${INPUT_DIR})
do

    if [ -d "${INPUT_DIR}/${d}" ]
    then
        OUTPUT_FILE="${OUTPUT_DIR}/${d}.txt"
        [ -e ${OUTPUT_FILE} ] && rm ${OUTPUT_FILE}
        cat ${INPUT_DIR}/${d}/*.txt > ${OUTPUT_FILE}
    fi
done
