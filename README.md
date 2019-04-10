# delete_small_files_comparison
Comparison of methods used to delete thousands of small files from a directory on Linux filesystems

rsync_empty_dir.sh - rsync an empty directory
find_delete.sh - find . -type f -delete
forloop.sh - for file in dir, rm file

doit.sh runs the tests and produces gnuplot compatible output

