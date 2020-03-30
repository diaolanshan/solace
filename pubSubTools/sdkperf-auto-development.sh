#!/bin/bash
log="out_$(date +%Y-%m-%d).txt"

user="v001.cu000001"
mvpn="v001"
cu="${user}@${mvpn}"
cp="d1abba2f-d7f9-45de-86be-5a63336d90f4"
cip="10.0.196.6:7001"

echo "---------------------------------------------------------------------" >> ${log} 2>&1
echo "----------------------- START -----------------------" >> ${log} 2>&1
for cc in 10 10
        do
                pql="queue1"
                n=2
                while [ "${n}" -le "$cc" ]
        do
                pql="${pql},queue${n}"
                n=$((n + 1 ))
        done
                for msa in 500 1000 2500 5000 10000 50000
                        do
                                if [ "$msa" -le 1000 ]; then
                                   mn="600000"
                                   mr="500000"
                                elif [ "$msa" -le 5000 ]; then
                                   mn="400000"
                                   mr="5000000"
                                elif [ "$msa" -le 20000 ]; then
                                   mn="200000"
                                   mr="500000"
                                elif [ "$msa" -le 50000 ]; then
                                   mn="200000"
                                   mr="500000"
                                elif [ "$msa" -le 250000 ]; then
                                   mn="50000"
                                   mr="500000"
                                elif [ "$msa" -le 1000000 ]; then
                                   mn="11000"
                                   mr="500000"
                                else
                                   mn="3000"
                                   mr="500000"
                                fi
                                echo "##################### START - clients: $cc | size: $msa | rate: $mr | messages: $mn #####################" >> ${log} 2>&1
                                echo "./sdkperf_c -cu=${cu} -cp=${cp} -cip=${cip} -cc=${cc} -mr=${mr} -msa=${msa} -mn=${mn} -pql=${pql} -mt=persistent -pe -sql=${pql}" >> ${log} 2>&1
                                ./sdkperf_c -cu=${cu} -cp=${cp} -cip=${cip} -cc=${cc} -mr=${mr} -msa=${msa} -mn=${mn} -pql=${pql} -mt=persistent -pe -sql=${pql} >> ${log} 2>&1
                        done
        done
echo "----------------------- DONE -----------------------" >> ${log} 2>&1
echo "----------------------- ALL DONE -----------------------" >> ${log} 2>&1
echo "---------------------------------------------------------------------" >> ${log} 2>&1
