FROM debian:jessie

EXPOSE 3389

VOLUME ["/etc/slapd/"]

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y ldap-utils slapd

RUN mkdir /tmp/slapd

COPY entrypoint.sh /
COPY slapd.conf /etc/ldap/slapd.conf

ENTRYPOINT ["/entrypoint.sh"]

CMD ["slapd", "-f", "/etc/ldap/slapd.conf", "-h", "ldap://0.0.0.0:3389/", "-d", "-1"]
