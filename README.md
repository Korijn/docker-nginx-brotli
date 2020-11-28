# Docker-nginx-brotli

I forked [lunatic-cat/docker-nginx-brotli](https://github.com/lunatic-cat/docker-nginx-brotli) because
although it brilliantly (read: with minimal maintenance requirements) extends the official `nginx:alpine`
image with the [google/ngx_brotli](https://github.com/google/ngx_brotli) modules, it also replaces
the default `nginx.conf` file, changing the official default configuration, and it also omits the
entrypoint scripts, which means you cannot benefit from environment substitution in configuration
template files, which is a very useful feature when you are working on
[twelve-factor apps](https://12factor.net/).

So, to summarize, the Dockerfile in this repository does not impact the official NGINX image in any way
other than adding the ngx_brotli modules and prepending two lines to the default configuration file to
load the modules. The official image's configuration and entrypoint are preserved.

# Where's the Docker image?

I did not build and publish this image, because I cannot promise to keep it up to date and regularly push
new builds. You are better off copying the content of this Dockerfile as a starting point for your project.

That way, everytime you build, you base your image off the latest and greatest `nginx:alpine` images, rather
than an outdated prebuilt image by my hand.

# Why is this not supported in the official image, anyway?

See https://github.com/nginxinc/docker-nginx/issues/371

## Thanks

- based on [lunatic-cat/docker-nginx-brotli](https://github.com/lunatic-cat/docker-nginx-brotli)
