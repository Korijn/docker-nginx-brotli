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

COPY your-nginx-vhost.conf /etc/nginx/conf.d/default.conf
COPY --from=builder --chown=nginx:nginx /app /usr/share/nginx/html
```

if you override `nginx.conf` with your config you still need this:

```nginx
load_module /usr/local/nginx/modules/ngx_http_brotli_filter_module.so;
load_module /usr/local/nginx/modules/ngx_http_brotli_static_module.so;

http {
    brotli on;
    brotli_static on;
}
```

## Thanks

- inspired by [fholzer/docker-nginx-brotli](https://github.com/fholzer/docker-nginx-brotli):
- using latest mainline nginx and [nginx brotli module](https://github.com/google/ngx_brotli)
- module compiled using this [receipe](https://gist.github.com/hermanbanken/96f0ff298c162a522ddbba44cad31081)
- using exactly same build flags as nginx-alpine, so it should be easy to update

