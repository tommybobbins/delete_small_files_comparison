# Deleting large numbers of small files from a directory.

Comparison of methods used to delete thousands of small files from a directory on Linux filesystems

## Methods used

1. Rsync an empty directory:
      
        rsync_empty_dir.sh

2. find and delete using /bin/find command:

        find_delete.sh

3. Perl unlink method:

        unlink_perl.pl

## Usage

Run the tests and produces gnuplot compatible output

    doit.sh

This calls the underlying scripts after generating the necessary files. Performs a sync between each run.

Needs tidying up considerably as was written in a hurry to prove how wrong I was.

## Results

For the below graphs, the lowest value of y is preferential as it represents seconds to remove files.

### Comparing all platforms


![Small file deletion platform comparison](deleting_small_files_all.png "Deletion of small files multi-platform")

### AWS t2-micro 100GB Provisioned SSD volume

Running doit.sh on the provisioned volume. Raw sesults are in AWS/

![Small file deletion AWS](deleting_small_files_aws.png "Deletion of small files AWS")

### ECloud Flex 100GB Provisioned SSD volume

Running doit.sh on the provisioned volume. Raw sesults are in FLEX/

![Small file deletion Flex](deleting_small_files_flex.png "Deletion of small files Flex")

### SSD Samsung EVO 850 250GB SSD.

Something very unusual happens here. find . -delete is slower and shows a non-exponential curve. Reproducible. Needs investigation.

![Small file deletion Flex](deleting_small_files_evo.png "Deletion of small files Samsung EVO 850")
