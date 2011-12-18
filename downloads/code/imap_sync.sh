#!/bin/bash

LOG="imapsync.log"

for i in `cat users`
do
    login1=`echo ${i} | awk -F: '{print $1}'`
    password1=`echo ${i} | awk -F: '{print $2}'`
    host1=`echo ${i} | awk -F: '{print $3}'`
    login2=`echo ${i} | awk -F: '{print $4}'`
    password2=`echo ${i} | awk -F: '{print $5}'`
    host2=`echo ${i} | awk -F: '{print $6}'`
   
   
    echo "-------------------" >> ${LOG}
    echo "LOGIN1: ${login1}" >> ${LOG}
    echo "PASSWORD1: ${password1}" >> ${LOG}
    echo "HOST1: ${host1}" >> ${LOG}
    echo "LOGIN2: ${login2}" >> ${LOG}
    echo "PASSWORD2: ${password2}" >> ${LOG}
    echo "HOST2: ${host2}" >> ${LOG}
#write password
    echo "${password1}" > pass1    
    echo "${password2}" > pass2  

#run sync
    /usr/bin/imapsync --authmech1 LOGIN --maxsize 52428800 --buffersize 52428800 --host1 ${host1} --user1 ${login1} --passfile1 pass1 -ssl1 -port1 993 --host2 ${host2} --user2 ${login2}  --passfile2 pass2 -ssl2 -port2 993 --authmech2 LOGIN  --fast --nofoldersizes --useheader Message-Id --noauthmd5 --skipsize --allow3xx --allowsizemismatch
done
