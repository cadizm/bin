#!/usr/bin/env python

import sys
from copy import deepcopy


# return list of k-combinations of L
def combinations(L, k):
    res = []
    ans = []
    combinations_(L, len(L), k, 0, ans, res)
    return res


def combinations_(L, n, k, start, ans, res):
    if len(ans) == k:
        res.append(deepcopy(ans))
        return
    i = start
    while i < n and k-len(ans) < n-i+1:
        ans.append(L[i])
        combinations_(L, n, k, i+1, ans, res)
        ans.pop()
        i += 1
