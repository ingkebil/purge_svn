#!/bin/bash
set -e

INFILE=${1}
TMPFILE=`mktemp`

# make sure that length of replacement is the same as the original!
exprs=(s/password/removeds/)

i=0
for f in "${exprs[@]}"; do
    echo $f
    if [[ $(( $i % 2 )) = 0 ]]; then
        sed "${f}" $INFILE >  $TMPFILE
    else
        sed "${f}" $TMPFILE > $INFILE
    fi
    i=$(( $i + 1 ))
done
if [[ $(( $i % 2 )) = 1 ]]; then
    mv $TMPFILE $INFILE
else
    rm $TMPFILE
fi
