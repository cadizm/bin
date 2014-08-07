#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

if [[ -z `which dumpkeys` ]]; then
    echo "dumpkeys not in PATH" 1>&2
    exit 1
fi

if [[ -z `which loadkeys ` ]]; then
    echo "loadkeys not in PATH" 1>&2
    exit 1
fi

dumpkeys | head -1 > /tmp/foo_keys
echo "keycode 58 = Control" >> /tmp/foo_keys
loadkeys /tmp/foo_keys
