#!/bin/bash

echo "====================================="
echo "Start time   : `date`"
echo "====================================="

#########################################

mg5=~/v2_3_0/MG5_aMC_v2_3_3
myfilename="100-250 250-500 500-1000 1000-2500 2500-4000 4000-6000 6000-Inf"
#event sayısını 10000 den 100000 e ayarlıyor
for say in $myfilename
do

sed -i '/  10000 = nevents ! Number of unweighted events requested/c\  100000 = nevents ! Number of unweighted events requested' ${mg5}/$say/Cards/run_card.dat


sed -i '/  10000 = nevents ! Number of unweighted events requested/c\  100000 = nevents ! Number of unweighted events requested' ${mg5}/$say/Cards/run_card_default.dat
done
cd $mg5
#diger sh dosyasını calıstırıyor
./subrun2.sh
exit 0
