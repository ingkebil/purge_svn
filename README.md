purge_svn
=========

Some scripts used to purge an SVN repo of data and passwords


1/ svn_purge_dir_contents.sh path [path [path...]]
For each path in the SVN repo given, the script will run svndumpfilter and exclude that path from the SVN dump file.

2/ reset.sh
Will remove a created SVN repo and recreate it.

3/ svn_runon.sh
Will run a bunch of sed regexes on the SVN dump file. Used to replace passwords.

4/ fix_svn_checksums.sh
When changing the content of an SVN dump file, you need to fix the checksums of all changed files across all revisions. Luckily for us, 'svnadmin load' will tell us exactly what we need to fix.
