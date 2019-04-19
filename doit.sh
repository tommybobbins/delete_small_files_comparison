#!/bin/bash
####Put name of output directory here
OUTPUTDIR=SEAGATE

create_files () {
DIRECTORY_TO_BREAK="BIGDIR"
BIG_FILENAME="bigfile"
BLOCKSIZE=$(( 4096 * 1096 ))
COUNT=100
SPLIT_BYTES=1000
SMALL_FILENAME="smallfile"

if [ -d ${DIRECTORY_TO_BREAK} ]
then
    rmdir ${DIRECTORY_TO_BREAK}
fi


if [ $1 -ge 1 ]
then
    COUNT=$1
fi

if [ $2 -ge 1 ]
then
    SPLIT_BYTES=$2
fi
#export NUMFILES=$(( ( $BLOCKSIZE* $COUNT )/ $SPLIT_BYTES ))

echo "$(( ( $BLOCKSIZE* $COUNT )/ $SPLIT_BYTES )) $SPLIT_BYTES"
mkdir ${DIRECTORY_TO_BREAK}
cd ${DIRECTORY_TO_BREAK}
dd if=/dev/zero of=${BIG_FILENAME} bs=${BLOCKSIZE} count=${COUNT} >/dev/null 2>&1
split -b ${SPLIT_BYTES} bigfile
rm bigfile
cd ../
echo 3 >/proc/sys/vm/drop_caches
sync
}
##################End of create_files()##########################

run_tests () {
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
    NUMFILES=$(create_files $1 $2)
    echo $NUMFILES
    TIMEFORMAT="$NUMFILES $TEST Total: %R"
    { time ./$TEST ; } 2>>${OUTPUT_FILE}
    sync
done
} # End of run_tests

#Main script
OUTLC=$(echo $OUTPUTDIR | tr [:upper:] [:lower:] )
if [ ! -d OUTPUT/${OUTPUTDIR} ]
then
    mkdir OUTPUT/${OUTPUTDIR}
fi
run_tests 10 10000
run_tests 20 10000
run_tests 30 10000
run_tests 40 10000
run_tests 80 10000
run_tests 100 10000
run_tests 80 1000
run_tests 40 1000
run_tests 30 1000
run_tests 20 1000
run_tests 100 1000
run_tests 1000 10000
run_tests 2000 10000
run_tests 3000 10000
run_tests 4000 10000
rsync -av /tmp/small_files* OUTPUT/${OUTPUTDIR}/
grep -h find_delete OUTPUT/$OUTPUTDIR/small*.txt | sort -h > find_delete_$OUTLC.txt
grep -h rsync_empty OUTPUT/$OUTPUTDIR/small*.txt | sort -h >rsync_empty_$OUTLC.txt
grep -h unlink_perl OUTPUT/$OUTPUTDIR/small*.txt | sort -h >unlink_perl_$OUTLC.txt
gnuplot 'OUTPUT/plotme'
