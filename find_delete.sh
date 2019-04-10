#!/bin/bash
BIGDIR="./BIGDIR"
if [ -d $BIGDIR ]
then
#    echo "Directory $BIGDIR exists"
   find $BIGDIR -type f -delete
fi
