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

Drilling down into the results which are less than 800 seconds:

![Small file deletion platform comparison](deleting_small_files_all_y800.png "Deletion of small files multi-platform")

### AWS t2-micro 100GB Provisioned SSD volume

Running doit.sh on the provisioned volume. Raw results are in AWS/

![Small file deletion AWS](deleting_small_files_aws.png "Deletion of small files AWS")

### ECloud Flex 100GB Provisioned SSD volume

Running doit.sh on the provisioned volume. Raw results are in FLEX/

![Small file deletion Flex](deleting_small_files_flex.png "Deletion of small files Flex")

### SSD Samsung EVO 850 250GB SSD.

Something very unusual happens here. find . -delete is slower and shows a non-exponential curve. Disk is used as the main operating system disk and this may have an impact on the tests. Treat with caution after reviewing the Intel results below.

![Small file deletion Flex](deleting_small_files_evo_ssd.png "Deletion of small files Samsung EVO 850")

### Intel 120GB SSDSC2BW120A4 SSD.

Run on an XFS filesystem

#### 1st run

Unusual tail off for rsync. This is due to the filesystem becoming full during the rsync and unlink_perl operations.Reviewing this find looks to be the best method here. 

![Small file deletion Intel_SSD](deleting_small_files_intelssd.png "Deletion of small files Intel SSD")

#### Second run

Run to see what happens at 2 million files.More investigation required.

![Small file deletion Intel_SSD](deleting_small_files_intelssd2.png "Deletion of small files Intel SSD")

#### Third run

Disk was reformatted as EXT4 and deletion re-run. This shows that rsync is the fastest method.
 
![Small file deletion Intel_SSD](deleting_small_files_intelssd3.png "Deletion of small files Intel SSD")

#### SATA disk HP 250GB SATA disk VB0250EAVER

Disk was formatted as EXT4
 
![Small file deletion SATA](deleting_small_files_seagate.png "Deletion of small files HP SATA Disk (Seagate)")

#### HGST dissk 1TB

![Small file deletion SATA](deleting_small_files_hgst.png "Deletion of small files HGST")

Disk was formatted as EXT4

#### VMWare ISCSI disk

Disk was formatted as EXT4
 
![Small file deletion VMWare](deleting_small_files_vmware_iscsi.png "Deletion of small files VMWare")
### Hetzner 100GB SSD.

Running doit.sh on the provisioned volume. Raw results are in HETZNER/

![Small file deletion Flex](deleting_small_files_hetzner.png "Deletion of small files Hetzner")
