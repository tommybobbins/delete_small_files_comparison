#!/usr/bin/perl
## matthews script to count files in a dir without stating them
## optional unlink of them as well.
#
opendir(DIR, BIGDIR);
while (my $f = readdir(DIR)) {
unlink(BIGDIR."/".$f);
}
