#!/usr/bin/bash


mkdir teslamain
cd teslamain
SLACK="https://hooks.slack.com/services/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"
subfinder -d tesla.com -v -recursive -o alltesla.txt

cat alltesla.txt | httpx | tee -a teslaalive.txt

while true;do cat teslaalive.txt | nuclei -t ~/nuclei-templates/ | slackcat -u $SLACK ; sleep 86400; done & 

while true;do subfinder -dL alltesla.txt -all | anew subs.txt | httpx | nuclei -t ~/nuclei-templates/ | slackcat -u $SLACK ; sleep 172800; done & 


