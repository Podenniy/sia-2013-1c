#!/bin/bash

mkdir boards
for i in $(seq 1 100); do
    python ./board-generator/generator2.py > boards/$i
done


