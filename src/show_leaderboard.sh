#!/bin/bash

if [ $# -ne 1 ]; then
    echo "expexting 1 arguments, got $#"
    exit 1
fi

i=1
while IFS= read -r line; do
    echo "Rank$i: $line"
    let "i = i+1"
done < $1