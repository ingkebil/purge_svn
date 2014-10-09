#!/bin/bash
set -e

# Just for testing purposes!
# Once a list of excluded prefixes is found, just run:
# svndumpfilter exclude --drop-empty-revs --renumber-revs --targets <file>
RERUN=/tmp/purged_contents.txt

INFILE=${1}
shift

TMPFILE=`mktemp`

i=0
for f in "$@"; do
    if [[ $(( $i % 2 )) = 0 ]]; then
        svndumpfilter exclude --drop-empty-revs --renumber-revs "${f}" < $INFILE > $TMPFILE
    else
        svndumpfilter exclude --drop-empty-revs --renumber-revs "${f}" < $TMPFILE > $INFILE
    fi
    echo "${f}" >> $RERUN
    i=$(( $i + 1 ))
done
if [[ $(( $i % 2 )) = 1 ]]; then
    mv $TMPFILE $INFILE
else
    rm $TMPFILE
fi
