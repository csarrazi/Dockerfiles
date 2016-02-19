#!/bin/bash

set -e
set -m

: ${LDAP_SUFFIX:="dc=example,dc=com"}
: ${LDAP_ROOTDN:="cn=admin,dc=example,dc=com"}
: ${LDAP_ROOTPW:="admin"}

echo >> /etc/ldap/slapd.conf
echo "suffix    \"$LDAP_SUFFIX\"" >> /etc/ldap/slapd.conf
echo "rootdn    \"$LDAP_ROOTDN\"" >> /etc/ldap/slapd.conf
echo "rootpw    \"$(slappasswd -s $LDAP_ROOTPW)\"" >> /etc/ldap/slapd.conf
echo >> /etc/ldap/slapd.conf

if [ "$1" = 'slapd' ]; then
    exec "$@" &
    sleep 3

    for f in /init-ldap.d/*; do
        case "$f" in
            *.sh ) echo "$0: running $f"; . "$f" ;;
            *.ldif)
                echo "$0: running $f";
                ldapadd -h localhost:389 -D $LDAP_ROOTDN -w $LDAP_ROOTPW -f "$f";
                ;;
            *) echo "$0: ignoring $f" ;;
        esac
        echo
    done

    fg
else
    exec "$@"
fi
