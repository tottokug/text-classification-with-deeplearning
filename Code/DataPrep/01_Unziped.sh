#!/bin/bash
PROJECT_HOME=$(cd $(dirname $0); cd ../../; pwd)
INPUT_DIR=${PROJECT_HOME}/Data/Raw
OUTPUT_DIR=${PROJECT_HOME}/Data/Processed/01_Unzipped

[ -e "${OUTPUT_DIR}" ] || mkdir ${OUTPUT_DIR}

for f in $(ls ${INPUT_DIR});
do
    unzip -O utf8 $f
done