#!/bin/bash
#olayın başladığı zaman ı kaydediyor
echo "====================================="
echo "Start time   : `date`"
echo "====================================="

#run_card dan nevents sayısını ayarlayabılırsınız.
# 100000 = nevents fo run_card.dat
#defi....
#mg5 programınızın yolunu tanitmanı gerekıyor
mg5=~/MG5_aMC_v2_3_3
#oluşturacagınız klasorlerın mınHt ve maxHt lerıne gore ayarlanması ıcın.
myfilename="100-250 250-500 500-1000 1000-2500 2500-4000 4000-6000 6000-Inf"

#run_card dan mınHt ve maxHt yı ayarlamanız ıcın tanımlanmıs
min=(100 250 500 1000 2500 4000 6000)
max=(250 500 1000 2500 4000 6000 100000)
#sayac
counter=0
#for döngüsünu dosyaları ayarlamak ver madevent yapmak ıcın baslatıyoruz
for say in $myfilename
do
  #out dosyalarının isimlerini binlere göre isimlendirip feynmann diahramlarını cızıyr
cd ${mg5}
sed -i '/output [a-z]*/c\output '"$say"'' ${mg5}/proc_card.dat

echo "====================================="
echo "$say feynnman diyagramlarını çizmeye başladı basladı   : `date`"
echo "====================================="

cd ${mg5}
./bin/mg5_aMC proc_card.dat

echo "====================================="
echo "$say feynnman dıyagramlarının cızımı bıttı   : `date`"
echo "====================================="



#cd $mg5/$say/Cards
#rm -r run_card.dat

#scp -r /home/dyilmaz/tezAnaliz/run_card_for_qcd/$say/run_card.dat ${mg5}/$say/Cards

#ht min ve max ları sed ile değiştiriyor
sed -i '/ 0.0   = htjmin ! minimum jet HT=Sum(jet pt)/c\ '${min[$counter]}'   = htjmin ! minimum jet HT=Sum(jet pt)' ${mg5}/$say/Cards/run_card.dat
sed -i '/ -1.0  = htjmax ! maximum jet HT=Sum(jet pt)/c\ '${max[$counter]}'   = htjmax ! maximum jet HT=Sum(jet pt)' ${mg5}/$say/Cards/run_card.dat

sed -i '/ 0.0   = htjmin ! minimum jet HT=Sum(jet pt)/c\ '${min[$counter]}'   = htjmin ! minimum jet HT=Sum(jet pt)' ${mg5}/$say/Cards/run_card_default.dat
sed -i '/ -1.0  = htjmax ! maximum jet HT=Sum(jet pt)/c\ '${max[$counter]}'   = htjmax ! maximum jet HT=Sum(jet pt)' ${mg5}/$say/Cards/run_card_default.dat

#sayacı 1 arttırıyor kı ht lerı ayarlarken array ıcınden bırer sonrasını alsın
counter=$((counter+1))
done

cd $mg5
./subrun1.sh

exit 0
