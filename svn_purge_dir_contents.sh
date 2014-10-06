#!/bin/bash
set -e

# Just for testing purposes!
# Once a list of excluded prefixes is found, just run:
# svndumpfilter exclude --drop-empty-revs --renumber-revs --targets <file>

i=0
for f in "$@"; do
    if [[ $(( $i % 2 )) = 0 ]]; then
        svndumpfilter exclude --drop-empty-revs --renumber-revs "${f}" < ~/svn/trost.filter.svn >  ~/svn/trost.filter..svn
    else
        svndumpfilter exclude --drop-empty-revs --renumber-revs "${f}" < ~/svn/trost.filter..svn > ~/svn/trost.filter.svn
    fi
    rm -Rf "${f}"
    i=$(( $i + 1 ))
done
if [[ $(( $i % 2 )) = 1 ]]; then
    mv ~/svn/trost.filter..svn ~/svn/trost.filter.svn
else
    rm ~/svn/trost.filter..svn
fi
