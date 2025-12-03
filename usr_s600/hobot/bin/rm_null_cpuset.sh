#!/bin/sh
# $1 is the relative path to empty cgroup
rmdir /sys/fs/cgroup/cpuset/$1
