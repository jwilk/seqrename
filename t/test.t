#!/usr/bin/env bash

# Copyright © 2019 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u
echo 1..1
pwd="$PWD"
tmpdir=$(mktemp -d -t lddot.XXXXXX)
cd "$tmpdir"
touch foo bar baz
"$pwd/seqrename" --format=f%04d *
exp='f0001 f0002 f0003'
diff=$(diff -u <(ls) <(printf '%s\n' $exp)) || true
if [ -n "$diff" ]
then
    sed -e 's/^/# /' <<< "$diff"
else
    echo 'ok 1'
fi
rm -rf "$tmpdir"

# vim:ts=4 sts=4 sw=4 et ft=sh
