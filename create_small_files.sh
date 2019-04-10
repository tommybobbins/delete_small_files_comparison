#!/bin/bash
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
