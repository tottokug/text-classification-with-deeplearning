#!/bin/bash
PROJECT_HOME=$(cd $(dirname $0); cd ../../; pwd)
INPUT_DIR=${PROJECT_HOME}/Data/Processed/02_UTF-8
OUTPUT_DIR=${PROJECT_HOME}/Data/Processed/03_removeHeaderFooter

[ -e "${OUTPUT_DIR}" ] || mkdir ${OUTPUT_DIR}
IFS='
'

for d in $(ls ${INPUT_DIR});
do
    [ -e "${OUTPUT_DIR}/${d}" ] || mkdir "${OUTPUT_DIR}/${d}"
    for f in $(ls ${INPUT_DIR}/$d);
    do
        INPUT_FILE="${INPUT_DIR}/$d/$f"
        OUTPUT_FILE="${OUTPUT_DIR}/$d/$f"
        echo "INPUT_FILE  = ${INPUT_FILE}"
        echo "OUTPUT_FILE = ${OUTPUT_FILE}"
        HEAD_LINE_COUNT=0
        FOOTER=0
        echo > "${OUTPUT_FILE}"
        for line in $(cat "${INPUT_DIR}/$d/$f")
        do
            if [[ "$line" =~ "底本：" ]];
            then 
                FOOTER=1
            elif [ "${HEAD_LINE_COUNT}" -ge 2 ] && [ ${FOOTER} -ne 1 ];
            then
                echo $line |perl -pe 's/［＃.*?］//g; s/《.*?》//g; s/｜//g' >> "${OUTPUT_FILE}"

            elif [[ "$line" =~ ^-{50,} ]]
            then
                HEAD_LINE_COUNT=$(expr "${HEAD_LINE_COUNT}" + 1)
            fi

           

            #cat "${INPUT_FILE}" | sed -e 's/［＃.*?］//g; s/《.*?》//g'
        done
    done
done