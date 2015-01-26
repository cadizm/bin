#!/bin/bash


function usage
{
    echo "Usage: $0 <AUTHOR> [FILES]"
}

if [[ "$#" -lt 1 ]]; then
    usage
    exit 1
fi

AUTHOR="$1"

if [[ -z "$2" ]]; then
    FILES=`find . -type f | grep -v '.git/'`
else
    FILES="$2"
fi

for FILE in ${FILES}; do
    NLINES=`wc -l ${FILE} | awk '{print $1}'`
    AUTHOR_LINES=`git blame $FILE | grep -i $AUTHOR | wc -l | awk '{print $1}'`
    AUTHOR_PERCENTAGE=`echo "scale=3;$AUTHOR_LINES/$NLINES" | bc`
    echo "$FILE,$AUTHOR,$NLINES,$AUTHOR_LINES,$AUTHOR_PERCENTAGE"
done
