#!/bin/bash

axiom-scan netflix -m dnsx -resp -o dns --cache
cat dns| awk '{ print $1 }' | anew alive
cat dns | tr -d '[]' | awk '{ print $2 }' | anew ips
wc -l ips
axiom-scan ips -m nmapx -T4 --top-ports 50 -oX nmap --threads 60 --cache
axiom-scan alive -m httpx -o http --cache
cat http| shuf | head -n 200 > sample-http
axiom-scan sample-http -m ffuf -wL quickhits.txt -o ffuf.csv --cache --threads 3
axiom-scan uber -m httpx -o uber-http --cache
axiom-scan uber-http -m hakrawler -plain --threads 3 -o crawl --cache

cd crawl
ls
find -size 0 -exec rm {} \;
ls

cat * | anew ../urls
cd ../

axiom-scan urls -m fff -oD fff
#vimprev $(find -name "*.headers")
