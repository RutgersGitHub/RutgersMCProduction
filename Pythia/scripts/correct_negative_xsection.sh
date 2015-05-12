#!/bin/bash

cat ${1} | awk '{if ( NR > 6 && NR < 90 && $1 < 0.0) {print "  0.000000E+00"," 0.000000E+00 ",$3"   "$4} else print}' > ${1%.lhe}_temp.lhe
mv ${1%.lhe}_temp.lhe ${1}
