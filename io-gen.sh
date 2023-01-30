#!/bin/sh

./kubestr fio -z 50G -s block-sc -f rand-write.fio -o json -e rand-RW-WL.json >& /dev/null &
