#!/usr/bin/bash

read -p "Enter Domain Name without http/https : " domain

#start finding subdomain

mkdir $domain
cd $domain

subfinder -d $domain -v -recursive -o all$domain.txt

cat all$domain.txt | httpx | tee -a $domain-alive.txt

while true;do cat $domain-alive.txt | nuclei -t ~/nuclei-templates/ | notify ; sleep 86400; done &

while true;do subfinder -dL all$domain.txt -all | anew all$domain-subs.txt | httpx | nuclei -t ~/nuclei-templates/ | notify ; sleep 172800; done &

