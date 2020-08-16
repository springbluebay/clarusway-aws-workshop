#!/bin/bash

#STEP-1 Check volumes on instance and dev path
lsblk
#STEP-2 Check file system
df -h
#STEP-3 Check if volume has any data
sudo file -s /dev/xvdf
# if no data -> /dev/xvdf:data

#STEP-4 Format volume
sudo mkfs -t ext4 /dev/xvdf

#STEP-5 Create mount directory
mkdir /newvolume

#STEP-6 Mount the volume
sudo mount /dev/xvdf /newvolume

#STEP-7 Check volume content
cd /newvolume
# lost+found for empty volume