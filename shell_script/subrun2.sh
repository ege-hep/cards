#!/bin/bash

echo "====================================="
echo "Start time   : `date`"
echo "====================================="

#########################################

mg5=~/MG5_aMC_v2_3_3
myfilename="100-250 250-500 500-1000 1000-2500 2500-4000 4000-6000 6000-Inf"
#multi_run Number
num_event=5


for say in $myfilename
do

cd ${mg5}/$say
echo "====================================="
echo "$say madevent start time  : `date`"
echo "====================================="
./bin/madevent multi_run $num_event -f --laststep=pythia
echo "====================================="
echo "$say madevent end time   : `date`"
echo "====================================="

done

exit 0
