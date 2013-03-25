#!/bin/bash

name=$(echo $@ | tr ' ' '-')

for i in $(find boards -type f); do
    python ./solver/main.py $i $@ 2>> $name || exit
done


