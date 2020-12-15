FROM alpine:edge
  
RUN echo https://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories

RUN apk --update add openvpn easy-rsa openresolv sipcalc bind-tools gettext

COPY bin /usr/local/bin

RUN /usr/local/bin/configure_sysctl.sh

RUN rm -rf /var/cache/apk/*

EXPOSE 1194/tcp
EXPOSE 1194/udp

CMD [ "/usr/local/bin/docker-entrypoint.sh" ]
