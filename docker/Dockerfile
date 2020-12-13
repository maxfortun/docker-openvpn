FROM alpine:edge
  
RUN echo https://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories

RUN apk --update add openvpn easy-rsa openresolv sipcalc

COPY bin /usr/local/bin

EXPOSE 1194/tcp
EXPOSE 1194/udp

