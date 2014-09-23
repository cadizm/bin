#!/usr/bin/perl -w

## Expects hexdump output as input
## Exact hexdump command w/ args: `hexdump -Cv <input>'


while (<>)
{
    if ($_ =~ m/^(.*?)\s{2}(.*?)\s{2}(.*?)\s{2}(?:\s*)(.*?)$/)
    {
        my ($line, $t1, $t2, $ascii) = ($1, $2, $3, $4);
    
        $t1 =~ s/(..)\s(..)/$1$2/g;
        $t2 =~ s/(..)\s(..)/$1$2/g;
    
        printf "%s  %-19s  %-19s  %-19s\n", $line, $t1, $t2, $ascii;
    }
    else
    {
        print $_;
    }
}
