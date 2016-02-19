FROM debian:jessie

EXPOSE 389

VOLUME ["/etc/slapd/"]

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y ldap-utils slapd

RUN mkdir /init-ldap.d
RUN mkdir -p /var/db/openldap

COPY slapd.conf /etc/ldap/slapd.conf
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["slapd", "-f", "/etc/ldap/slapd.conf", "-h", "ldap://0.0.0.0:389/", "-d", "-1"]
