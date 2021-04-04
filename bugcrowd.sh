#!/usr/bin/bash

read -p "Enter Domain Name without http/https : " domain

#start finding subdomain

mkdir $domain
cd $domain
SLACK="https://hooks.slack.com/services/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"
subfinder -d $domain -v -recursive -o all$domain.txt

cat all$domain.txt | httpx | tee -a $domain-alive.txt

while true;do cat $domain-alive.txt | nuclei -t ~/nuclei-templates/ | slackcat -u $SLACK ; sleep 86400; done &

while true;do subfinder -dL all$domain.txt -all | anew all$domain-subs.txt | httpx | nuclei -t ~/nuclei-templates/ | slackcat -u $SLACK ; sleep 172800; done &

