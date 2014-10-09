# PURGE SVN

Some scripts used to purge an SVN repo of data and passwords.
When changing passwords in an SVN dump file, you will get md5hash mismatches when reloading the dump.


## svn_purge_dir_contents.sh path svn.dump [path [path...]]
For each path in the SVN repo given, the script will run svndumpfilter and exclude that path from the SVN dump file.
This script will automate rotating between two files while running svndumpfilter to exclude one path at the time.

## reset.sh
Will remove a created SVN repo and recreate it.

## svn_runon.sh
Will run a bunch of sed regexes on the SVN dump file. Used to replace passwords.
This script will automate rotating between two files while running sed to rename passwords one password at the time.
BE AWARE: Replacing passwords will invalidate the md5checksum for each file that is changed this way. This can be fixed with fix_svn_checksums.sh. What the script doesn't do is recalculate the content-length of the changed file, so make sure the changed passwords are of the same length!

## fix_svn_checksums.sh
When changing the content of an SVN dump file, you need to fix the checksums of all changed files across all revisions. Luckily for us, 'svnadmin load' will tell us exactly what we need to fix.
This script automates the loading of the svn.dump file, catching the md5checksum error, sed'ing the md5checksum to the valid one and restarting. 
