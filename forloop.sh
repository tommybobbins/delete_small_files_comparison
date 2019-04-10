#/bin/bash

if [ -d $BIGDIR ]
then
    for i in `ls BIGDIR/*`
    do
       rm -f $i
    done
fi
