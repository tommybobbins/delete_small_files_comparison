#!/bin/bash
TIMEFORMAT="$0 Total: %R"
OUTPUT_FILE=/tmp/small_files_$1_$2.txt
rm -f ${OUTPUT_FILE}
echo "Numfiles   Size     Method     Time" > ${OUTPUT_FILE}
for TEST in find_delete.sh unlink_perl.pl  rsync_empty_dir.sh
#for TEST in forloop.sh
do
    if [ -d BIGDIR ]
    then
        rmdir BIGDIR
    fi
    echo "$TEST"
    NUMFILES=`./create_small_files.sh $1 $2`
    echo $NUMFILES
    TIMEFORMAT="$NUMFILES $TEST Total: %R"
    { time ./$TEST ; } 2>>${OUTPUT_FILE}
    sync
done
