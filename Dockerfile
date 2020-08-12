FROM alpine:3.12

RUN apk add --no-cache openssh-client

COPY setup-ssh /usr/local/bin/
