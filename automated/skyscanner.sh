#!/usr/bin/bash


mkdir skyscanner
cd skyscanner
SLACK="https://hooks.slack.com/services/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"
subfinder -d skyscanner.net -v -recursive -o allskyscanner.txt

cat allskyscanner.txt | httpx | tee -a skyalive.txt

while true;do cat skyalive.txt | nuclei -t ~/nuclei-templates/ | slackcat -u $SLACK ; sleep 86400; done & 

while true;do subfinder -dL allskyscanner.txt -all | anew subs.txt | httpx | nuclei -t ~/nuclei-templates/ | slackcat -u $SLACK ; sleep 172800; done &  


