# Docker-nginx-brotli

Mainline nginx serving [brotli](https://github.com/google/brotli)-compressed content

## Example

```bash
docker run -p 80:80 lunaticcat/nginx-brotli
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

An example `Dockerfile` with cpu-offloading by AOT precompilation:

```dockerfile
FROM alpine AS builder

RUN apk update && apk add brotli findutils
RUN mkdir /app && cd /app

# COPY your static content to `/app`
find /app -regextype posix-egrep -regex '.*(\.js|\.css|\.svg|\.ttf|\.webp|\.jpg|\.png|\.ico|\.html)' -exec brotli {} \;

FROM lunaticcat/nginx-brotli

# COPY your nginx vhost to `/app`
COPY --from=builder --chown=nginx:nginx /app /usr/share/nginx/html
```

## Thanks

Updated version of [fholzer/docker-nginx-brotli](https://github.com/fholzer/docker-nginx-brotli):
latest alpine + mainline nginx + latest [nginx brotli
module](https://github.com/google/ngx_brotli) atm.

