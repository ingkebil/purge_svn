#!/bin/bash
set -e

# make sure that length of replacement is the same as the original!
exprs=(s/password/removeds/)

i=0
for f in "${exprs[@]}"; do
    echo $f
    if [[ $(( $i % 2 )) = 0 ]]; then
        sed "${f}" ~/svn/trost.filter.svn >  ~/svn/trost.filter..svn
    else
        sed "${f}" ~/svn/trost.filter..svn > ~/svn/trost.filter.svn 
    fi
    rm -Rf "${f}"
    i=$(( $i + 1 ))
done
if [[ $(( $i % 2 )) = 1 ]]; then
    mv ~/svn/trost.filter..svn ~/svn/trost.filter.svn
else
    rm ~/svn/trost.filter..svn
fi
