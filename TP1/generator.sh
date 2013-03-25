#!/bin/bash

mkdir boards
for i in $(seq 1 100); do
    python ./board_generator/generator2.py > boards/$i
done


