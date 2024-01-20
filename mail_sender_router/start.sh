#!/bin/bash
# https://blog.fhrnet.eu/2017/10/29/postfix-routing-outgoing-email-to-relay-based-on-sender-domain/

echo "##### CONFIGURING POSTFIX #####"

relays="#Generated by start.sh\n"
counter=1

while [ -n "$(eval echo \$EMAIL_${counter})" ]; do
  echo "Relaying from $(eval echo \$EMAIL_${counter}) via $(eval echo \$SERVER_${counter})"
  relays+="$(eval echo \$EMAIL_${counter})    $(eval echo \$SERVER_${counter})\n"
  ((counter++))
done

credentials="#Generated by start.sh\n"
counter=1

while [ -n "$(eval echo \$EMAIL_${counter})" ]; do
  credentials+="$(eval echo \$SERVER_${counter})    $(eval echo \$CREDENTIALS_${counter})\n"
  ((counter++))
done


printf "$relays" > /etc/postfix/relay_maps
postmap /etc/postfix/relay_maps

printf "$credentials" > /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd

echo "setting allowed networks to $TRUSTED_NETWORKS"
postconf -e "mynetworks = $TRUSTED_NETWORKS"

echo deleting old resolv.conf
rm /var/spool/postfix/etc/resolv.conf
echo creating new resolv.conf
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

if [ -n "$TLS_ONLY" ]; then
  echo "TLS_ONLY is set, forcing TLS"
  postconf -e "smtpd_tls_security_level = encrypt"
else
  echo "TLS_ONLY is not set, TLS is optional"
  postconf -e "smtpd_tls_security_level = may"
fi

echo "configuration done"

if [ ! -f /etc/ssl/store/certs/ssl.cer ]; then
  echo "##### GENERATING NEW SSL CERTIFICATE #####"
  hostname=$(hostname)
  mkdir /tmp/ssl
  openssl genrsa -des3 --passout pass:1111 -out /tmp/ssl/rsa.key 4096
  openssl req -new -passin pass:1111 -key /tmp/ssl/rsa.key -subj "/C=DE/ST=Bayern/L=Tuessling/O=Rahn-IT/OU=IT/CN=$hostname"  -out /tmp/ssl/rsa.csr
  openssl x509 -req --passin  pass:1111 -days 3650 -in /tmp/ssl/rsa.csr -signkey /tmp/ssl/rsa.key -out /tmp/ssl/rsa.cer
  openssl rsa --passin pass:1111  -in /tmp/ssl/rsa.key -out /tmp/ssl/rsa.key.nopass
  mv -f /tmp/ssl/rsa.key.nopass /tmp/ssl/rsa.key
  openssl req -new -x509 -extensions v3_ca -passout pass:1111 -subj "/C=DE/ST=Bayern/L=Tuessling/O=Rahn-IT/OU=IT/CN=$hostname"  -keyout /tmp/ssl/cakey.pem -out /tmp/ssl/cacert.cer -days 3650
  mkdir -p /etc/ssl/store/private /etc/ssl/store/certs
  mv /tmp/ssl/rsa.key /etc/ssl/store/private/ssl.key
  mv /tmp/ssl/rsa.cer /etc/ssl/store/certs/ssl.cer
  mv /tmp/ssl/cacert.cer /etc/ssl/store/certs/ca.cer
  mv /tmp/ssl/cakey.pem /etc/ssl/store/private/ca.key
  rm -r /tmp/ssl
fi

# echo "##### CURRENT CA CERTIFICATE #####"
# cat /etc/ssl/store/certs/ca.cer
echo "##### CURRENT SSL CERTIFICATE #####"
cat /etc/ssl/store/certs/ssl.cer

echo "##### STARTING POSTFIX #####"


exec postfix start-fg

echo 