#!/bin/bash

rm -rf demo
mkdir -p demo
cp src/* demo
start="$(date +%s)"
cd demo && zsh
end="$(date +%s)"
total_seconds="$(echo "$end - $start" | bc -l)"
cd ..
tar -cvzf nahamcon-recon-village-demo.tar.gz demo
mv nahamcon-recon-village-demo.tar.gz ~/infra/www/i/nahamcon-recon-village-demo.tar.gz
echo "Demo took a total of $total_seconds total seconds."
echo "Download link available: https://i.pry0.cc/nahamcon-recon-village-demo.tar.gz"
