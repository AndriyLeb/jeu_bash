#!/bin/bash

if [ $# -ne 1 ]; then
    echo "expexting 1 arguments, got $#"
    exit 1
fi

> $1