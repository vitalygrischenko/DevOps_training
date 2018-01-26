#!/bin/bash
yum update -y
yum install -y git
git clone -b task2 https://github.com/vitalygrischenko/DevOps_training.git
cat DevOps_training/task2.txt