#!/bin/bash

mkdir -p "$(dirname $0)/client_certs"
cd "$(dirname $0)/client_certs"

CA_CLIENT_KEY_PASS="${CA_CLIENT_KEY_PASS}"
CLIENT_KEY_PASS="${CLIENT_KEY_PASS}"
SERVER_TRUST_PASS="${SERVER_TRUST_PASS}"

if [ -z "$CA_CLIENT_KEY_PASS" ]
then
      echo "Please set CA_STORE_PASS environment variable."
      exit 1;
fi

if [ -z "$CLIENT_KEY_PASS" ]
then
      echo "Please set CLIENT_KEY_PASS environment variable."
      exit 1;
fi

if [ -z "$SERVER_TRUST_PASS" ]
then
      echo "Please set SERVER_TRUST_PASS environment variable."
      exit 1;
fi

echo "\Create key store for clients.\n"
keytool -genkey -keyalg RSA -keysize 2048 -keystore client.ks.p12           \
  -storepass $CLIENT_KEY_PASS -keypass $CLIENT_KEY_PASS -alias client   \
  -storetype PKCS12 -dname "CN=Kafka,O=Confluent,C=GB" -validity 365
  
keytool -certreq -file client.csr -keystore client.ks.p12 -storetype PKCS12 \
  -storepass $CLIENT_KEY_PASS -keypass $CLIENT_KEY_PASS -alias client
keytool -gencert -infile client.csr -outfile client.crt                     \
  -keystore ../ca_authority/client.ca.p12 -storetype PKCS12 -storepass $CA_CLIENT_KEY_PASS   \
  -alias ca -validity 365
  
cat client.crt  ../ca_authority/client.ca.crt > clientchain.crt
keytool -importcert -file clientchain.crt -keystore client.ks.p12           \
  -storepass $CLIENT_KEY_PASS -keypass $CLIENT_KEY_PASS -alias client   \
  -storetype PKCS12 -noprompt 
  
echo "\nAdd client CA certificate to broker's trust store.\n"
keytool -import -file  ../ca_authority/client.ca.crt -keystore ../server_certs/server.ts.p12 -alias client \
   -storetype PKCS12 -storepass $SERVER_TRUST_PASS -noprompt
  
