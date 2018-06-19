#!/bin/bash
PROJECT_HOME=$(cd $(dirname $0); cd ../../; pwd)
INPUT_DIR=${PROJECT_HOME}/Data/Processed/03_removeHeaderFooter
OUTPUT_DIR=${PROJECT_HOME}/Data/Processed/04_rename

BOOK_MASTER=${OUTPUT_DIR}/master.csv
echo > ${BOOK_MASTER}
[ -e "${OUTPUT_DIR}" ] || mkdir ${OUTPUT_DIR}
IFS='
'

AUTHOR_COUNT=1;
for d in $(ls ${INPUT_DIR})
do
    BOOK_COUNT=1;
    [ -e "${OUTPUT_DIR}/`printf %04d ${AUTHOR_COUNT}`" ] || mkdir "${OUTPUT_DIR}/`printf %04d ${AUTHOR_COUNT}`"
    for f in $(ls ${INPUT_DIR}/$d);
    do
        INPUT_FILE="${INPUT_DIR}/${d}/${f}"
        OUTPUT_FILE="${OUTPUT_DIR}/`printf %04d ${AUTHOR_COUNT}`/`printf %04d ${BOOK_COUNT}`.txt"
        echo "INPUT_FILE  = ${INPUT_FILE}"
        echo "OUTPUT_FILE = ${OUTPUT_FILE}"
        cp ${INPUT_FILE} ${OUTPUT_FILE}
        echo "\"$(printf %04d ${AUTHOR_COUNT})/$(printf %04d ${BOOK_COUNT}).txt\",\"${d}\",\"${f}\"" >> ${BOOK_MASTER}
        BOOK_COUNT=$(expr "${BOOK_COUNT}" + 1 )
    done
    AUTHOR_COUNT=$(expr "${AUTHOR_COUNT}" + 1 )
done
