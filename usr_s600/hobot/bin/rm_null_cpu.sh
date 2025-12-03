#!/bin/sh
# $1 is the relative path to empty cgroup
rmdir /sys/fs/cgroup/cpu,cpuacct/$1
