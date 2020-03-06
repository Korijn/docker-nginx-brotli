# Docker-nginx-brotli

Single-line config to serve [brotli](https://github.com/google/brotli)-compressed content

## Example

```bash
docker run -p 80:80 lunaticcat/nginx-brotli:1.17.9-alpine-perl
```

```bash
curl -sI -X GET localhost | grep -E 'Content-Length|Content-Encoding'
Content-Length: 718
```

```bash
curl -sI -X GET localhost -H 'accept-encoding: gzip' | grep -E 'Content-Length|Content-Encoding'
Content-Length: 419
Content-Encoding: gzip
```

But [more than 90%](https://caniuse.com/#feat=brotli) browsers send this:

```bash
curl -sI -X GET localhost -H 'accept-encoding: gzip, deflate, br' | grep -E 'Content-Length|Content-Encoding'
Content-Length: 270
Content-Encoding: br
```

## Usage

```nginx
# nginx http section
brotli on;
brotli_static on;
```

Offload CPU by preparing your static files like this

```bash
apt install brotli

# simply html
brotli /usr/share/nginx/html/*html

# or deep nested various resources
find www-root-dir -regextype posix-egrep -regex '.*(\.js|\.css|\.svg|\.ttf|\.webp|\.jpg|\.png|\.ico|\.html)' -exec brotli --input {} --output {}.br \;
```

## Thanks

Updated version of [fholzer/docker-nginx-brotli](https://github.com/fholzer/docker-nginx-brotli):
latest alpine + mainline nginx + [nginx brotli
module](https://github.com/google/ngx_brotli) atm.
