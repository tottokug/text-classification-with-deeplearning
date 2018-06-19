#!/bin/bash
PROJECT_HOME=$(cd $(dirname $0); cd ../../; pwd)
INPUT_DIR=${PROJECT_HOME}/Data/Processed/05_merge
OUTPUT_DIR=${PROJECT_HOME}/Data/Processed/06_split

SPLIT_RATE=0.7

[ -e "${OUTPUT_DIR}" ] || mkdir ${OUTPUT_DIR}
IFS='
'
[ -e  ${OUTPUT_DIR}/Train ] || mkdir ${OUTPUT_DIR}/Train
[ -e  ${OUTPUT_DIR}/Test ] || mkdir ${OUTPUT_DIR}/Test


for f in $(ls ${INPUT_DIR})
do
    if [ -f "${INPUT_DIR}/${f}" ]
    then
        INPUT_FILE="${INPUT_DIR}/${f}"
        TRAIN_OUTPUT_FILE="${OUTPUT_DIR}/Train/${f}"
        TEST_OUTPUT_FILE="${OUTPUT_DIR}/Test/${f}"
        LINE_COUNT=$(wc -l ${INPUT_FILE} | cut -d'/' -f1 | sed -e 's/ //g')
        echo "scale=1; ${LINE_COUNT} * ${SPLIT_RATE}"
        TRAIN_LINE_COUNT=$(echo "scale=1; ${LINE_COUNT} * ${SPLIT_RATE}" | bc -q )
        echo ${TRAIN_LINE_COUNT%.*}
        head -n ${TRAIN_LINE_COUNT%.*} $INPUT_FILE > ${TRAIN_OUTPUT_FILE}
        tail -n $(expr ${LINE_COUNT} - ${TRAIN_LINE_COUNT%.*} ) $INPUT_FILE > ${TEST_OUTPUT_FILE}
    fi
done
