#!/usr/bin/bash


mkdir deliveroo 
cd deliveroo	
SLACK="https://hooks.slack.com/services/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"
subfinder -d deliveroo-data.net -v -recursive -o alldeliveroo-data.net.txt
subfinder -d deliveroo-data.io -v -recursive -o alldeliveroo-data.io.txt
subfinder -d deliveroo-data-test.io -v -recursive -o alldeliveroo-data-test.io.txt
subfinder -d 1debit.com -v -recursive -o alldebit.txt

cat alldeliveroo-data.net.txt | httpx | tee -a alldeliveroo-data-alive.txt
cat alldeliveroo-data.io.txt | httpx | tee -a alldeliveroo-data.io-alive.txt
cat alldeliveroo-data-test.io.txt | httpx | tee -a alldeliveroo-data-test.io-alive.txt
cat alldeliveroo.txt | httpx | tee -a alldeliveroo-alive.txt

while true;do cat alldeliveroo-data-alive.txt | nuclei -t ~/nuclei-templates/ | notify ; sleep 86400; done & 

while true;do cat alldeliveroo-data.io-alive.txt | nuclei -t ~/nuclei-templates/ | notify ; sleep 86400; done & 

while true;do cat alldeliveroo-data-test.io-alive.txt | nuclei -t ~/nuclei-templates/ | notify ; sleep 86400; done &

while true;do cat alldeliveroo-alive.txt | nuclei -t ~/nuclei-templates/ | notify ; sleep 86400; done &

while true;do subfinder -dL alldeliveroo-data.net.txt -all | anew deliveroo-net.txt | httpx | nuclei -t ~/nuclei-templates/ | notify ; sleep 172800; done & 

while true;do subfinder -dL alldeliveroo-data.io.txt -all | anew deliveroo-data-subs.txt | httpx | nuclei -t ~/nuclei-templates/ | notify ; sleep 172800; done &


while true;do subfinder -dL alldeliveroo-data-test.io.txt -all | anew deliveroo-data-test-subs.txt | httpx | nuclei -t ~/nuclei-templates/ | notify ; sleep 172800; done &

while true;do subfinder -dL alldeliveroo.txt -all | anew alldeliveroo-subs.txt | httpx | nuclei -t ~/nuclei-templates/ | notify ; sleep 172800; done &

