# Live Demo 🔥

# 160 instances! Digitalocean!

## Resolve Netflix Domains

```bash
axiom-scan netflix -m dnsx -resp -o dns --cache
```

`00h:00m:44s`

## Extract alive subdomains and IP addresses from output

```bash
cat dns| awk '{ print $1 }' | anew alive
cat dns | tr -d '[]' | awk '{ print $2 }' | anew ips
wc -l ips
```

`00h:01m:44s`

### Use `Nmapx` to scan all ips

```bash
axiom-scan ips -m nmapx -T4 --top-ports 50 -oX nmap --threads 60 --cache
```

`00h:00m:51s`

### Use `httpx`  to discover HTTP servers on Netflix

```bash
axiom-scan alive -m httpx -o http --cache
cat http| shuf | head -n 200 > sample-http
```

`00h:02m:51s`

### Perform distributed ffuf content discovery with a custom wordlist

```bash
axiom-scan sample-http -m ffuf -wL quickhits.txt -o ffuf.csv --cache --threads 3
```

`00h:01m:27s`

### Crawl Uber using httpx & hakrawler

```bash
axiom-scan uber -m httpx -o uber-http --cache
axiom-scan uber-http -m hakrawler -plain --threads 3 -o crawl --cache

cd crawl
ls
find -size 0 -exec rm {} \;
ls

cat * | anew ../urls
cd ../
```

`00h:01m:00s`

### Download files and response headers using fff

```bash
axiom-scan urls -m fff -oD fff
vimprev $(find -name "*.headers")
```