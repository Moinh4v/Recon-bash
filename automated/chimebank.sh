#!/usr/bin/bash


mkdir chimebank
cd chimebank
SLACK="https://hooks.slack.com/services/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"
subfinder -d chimebank.com -v -recursive -o allchimebank.txt
subfinder -d chimecard.com -v -recursive -o allchimecard.txt
subfinder -d chime.com -v -recursive -o allchime.txt
subfinder -d 1debit.com -v -recursive -o alldebit.txt

cat allchimebank.txt | httpx | tee -a allchimebankalive.txt
cat allchimecard.txt | httpx | tee -a allchimecardalive.txt
cat allchime.txt | httpx | tee -a allchimealive.txt
cat alldebit.txt | httpx | tee -a alldebitalive.txt

while true;do cat allchimebankalive.txt | nuclei -t ~/nuclei-templates/ | notify ; sleep 86400; done & 

while true;do cat allchimecardalive.txt | nuclei -t ~/nuclei-templates/ | notify ; sleep 86400; done & 

while true;do cat allchimealive.txt | nuclei -t ~/nuclei-templates/ | notify ; sleep 86400; done &

while true;do cat alldebitalive.txt | nuclei -t ~/nuclei-templates/ | notify ; sleep 86400; done &

while true;do subfinder -dL allchimebank.txt -all | anew chime-subs.txt | httpx | nuclei -t ~/nuclei-templates/ | notify ; sleep 172800; done & 

while true;do subfinder -dL allchimecard.txt -all | anew chimecard-subs.txt | httpx | nuclei -t ~/nuclei-templates/ | notify ; sleep 172800; done &


while true;do subfinder -dL allchime.txt -all | anew chimemain-subs.txt | httpx | nuclei -t ~/nuclei-templates/ | notify ; sleep 172800; done &

while true;do subfinder -dL alldebit.txt -all | anew chimedebit-subs.txt | httpx | nuclei -t ~/nuclei-templates/ | notify ; sleep 172800; done &

