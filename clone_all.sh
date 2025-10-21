#!/bin/bash
N=`cat list.txt | wc -l`
i=0
while [ $i -le $N ]; do
    name=`awk "NR==$i" list.txt`
    name2="https://github.com/UWSEDS/hw1-"
    git clone $name2$name.git
    i=$(($i+1))
done

