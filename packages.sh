#!/usr/bin/env bash
set -euo pipefail

GUTS=`grep -h "^library" *.Rmd | sort | uniq | sed -e 's/^library(//' -e 's/)$//' | paste -sd ','`
echo "install.packages(c($GUTS))"
