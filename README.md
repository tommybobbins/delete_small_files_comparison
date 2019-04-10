# delete_small_files_comparison
Comparison of methods used to delete thousands of small files from a directory on Linux filesystems

Rsync an empty directory:
    rsync_empty_dir.sh
find and delete using /bin/find command:
    find_delete.sh
Perl unlink method
    unlink_perl.pl

doit.sh runs the tests and produces gnuplot compatible output

Needs tidying up considerably as was written in a hurry to prove how wrong I was.
