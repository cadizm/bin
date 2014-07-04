#!/bin/bash

#
# OPTIND index of the next  argument to  be processed
# OPTARG the option argument
#

function usage
{
    cat << EOF
Usage: $0 [-a] [-b] [infile]
EOF
}


aflag=
bflag=
bval=

while getopts "ab:" NAME; do
    case $NAME in
        a) aflag=1;;
        b) bflag=1
           bval="$OPTARG";;
        ?) usage;;
    esac
done

printf "aflag %s\n"  $aflag
printf "bflag %s\n"  $bflag $bval
printf "bval %s\n"  $bflag $bval
