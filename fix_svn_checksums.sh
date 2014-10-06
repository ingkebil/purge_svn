#!/bin/bash

# create a rerun file
RERUN=/tmp/fixed_checksums.sh
echo 'sed ' > $RERUN

SVN_TARGET=`mktemp -d`   # we will dump the svn a lot, put it on a different location to not stress journald so much

EXPECTED='x'
while [[ -n $EXPECTED ]]; do
    echo 'Reseting trost repo ...'
    ERRPUT=/tmp/reset.err
    OUTPUT=/tmp/reset.out
    echo -n "\tRemoving previous repo $SVN_TARGET ..."
    rm -Rf $SVN_TARGET
    echo ' done.'
    SVN_TARGET=`mktemp -d`
    echo -n "\tCreating $SVN_TARGET ..."
    svnadmin create $SVN_TARGET
    svnadmin load $SVN_TARGET < $1 1> $OUTPUT 2> $ERRPUT
    echo ' done!'

    grep 'Committed revision' $OUTPUT | tail -1

    EXPECTED=`grep expected: $ERRPUT | sed "s/ *expected:  //"`
    ACTUAL=`grep actual: $ERRPUT | sed "s/ *actual:  //"`

    if [[ -z $EXPECTED ]]; then
        rm -Rf $SVN_TARGET
        echo 'Fixed all revisions!'
        exit 0
    fi

    echo -n "Fixing $EXPECTED revision to $ACTUAL ... "
    echo "-e s/$EXPECTED/$ACTUAL/ " >> $RERUN
    SVN_DUMP=`mktemp`
    sed s/$EXPECTED/$ACTUAL/ $1 > $SVN_DUMP
    mv $SVN_DUMP $1
    echo ' done!'
    sleep 60
done

echo "Rerun file saved at $RERUN"
