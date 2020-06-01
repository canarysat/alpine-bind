FROM alpine:latest

LABEL maintainer="Peter CanarySAT <peter@canarysat.com>" \
      architecture="amd64/x86_64" \
      bind-version="latest" \
      alpine-version="latest" \
      build="31-May-2020" \
      org.opencontainers.image.title="alpine-dns" \
      org.opencontainers.image.description="Bind DNS Server Docker image running on Alpine Linux" \
      org.opencontainers.image.authors="Peter Canarysat <peter@canarysat.com>" \
      org.opencontainers.image.vendor="CanarySAT" \
      org.opencontainers.image.version="v1.0" \
      org.opencontainers.image.url="https://hub.docker.com/r/canarysat/alpine-dns/" \
      org.opencontainers.image.source="https://github.com/canarysat/alpine-dns" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.created=$BUILD_DATE

#
# Install all required dependencies.
#

RUN apk --update upgrade && \
    apk add --update bind && \
    rm -rf /var/cache/apk/*


#
# Add named init script.
#

ADD init.sh /init.sh
RUN chmod 750 /init.sh


#
# Define container settings.
#

VOLUME ["/etc/bind", "/var/log/named"]

EXPOSE 53/udp

WORKDIR /etc/bind


#
# Start named.
#

CMD ["/init.sh"]
