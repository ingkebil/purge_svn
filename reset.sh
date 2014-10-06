rm -Rf ~/svnadmin/trost
svnadmin create ~/svnadmin/trost
svnadmin load ~/svnadmin/trost < $1 2> /tmp/reset.err
