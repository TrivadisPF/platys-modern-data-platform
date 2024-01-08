#!/bin/bash

mkdir -p "$(dirname $0)/server_certs"
mkdir -p "$(dirname $0)/client_certs"
cd "$(dirname $0)/server_certs"

SERVER_CN="${SERVER_CN}"
CA_STORE_PASS="${CA_STORE_PASS}"
SERVER_KEY_PASS="${SERVER_KEY_PASS}"
SERVER_TRUST_PASS="${SERVER_TRUST_PASS}"
CLIENT_TRUST_PASS="${CLIENT_TRUST_PASS}"

if [ -z "$SERVER_CN" ]
then
      echo "Please set SERVER_CN environment variable."
      exit 1;
fi

if [ -z "$CA_SERVER_KEY_PASS" ]
then
      echo "Please set CA_SERVER_KEY_PASS environment variable."
      exit 1;
fi

if [ -z "$SERVER_KEY_PASS" ]
then
      echo "Please set SERVER_KEY_PASS environment variable."
      exit 1;
fi

if [ -z "$SERVER_TRUST_PASS" ]
then
      echo "Please set SERVER_TRUST_PASS environment variable."
      exit 1;
fi

if [ -z "$CLIENT_TRUST_PASS" ]
then
      echo "Please set CLIENT_TRUST_PASS environment variable."
      exit 1;
fi

for i in {1..3}
do
	echo "\nGenerating Private Key for Broker.\n"
	keytool -genkey -keyalg RSA -keysize 2048 -keystore server.$SERVER_CN-$i.ks.p12         \
  		-storepass $SERVER_KEY_PASS -keypass $SERVER_KEY_PASS -alias server   \
  		-storetype PKCS12 -dname "CN=Kafka,O=Confluent,C=GB" -validity 365

	echo "\nGenerate a certificate signing request.\n"
	keytool -certreq -file server.$SERVER_CN-$i.csr -keystore server.$SERVER_CN-$i.ks.p12 -storetype PKCS12 \
  		-storepass $SERVER_KEY_PASS -keypass $SERVER_KEY_PASS -alias server

	echo "\nUse the CA key store to sign the broker’s certificate.\n"
	keytool -gencert -infile server.$SERVER_CN-$i.csr -outfile server.$SERVER_CN-$i.crt \
  		-keystore ../ca_authority/server.ca.p12 -storetype PKCS12 -storepass $CA_SERVER_KEY_PASS \
  		-alias ca -ext SAN=DNS:$SERVER_CN-$i -validity 365  
done

echo "\nImport the broker’s certificate chain into the broker’s key store.\n"
for i in {1..3} 
do 
	cat server.$SERVER_CN-$i.crt ../ca_authority/server.ca.crt > serverchain.crt

	keytool -importcert -file serverchain.crt -keystore server.$SERVER_CN-$i.ks.p12         \
 		-storepass $SERVER_KEY_PASS -keypass $SERVER_KEY_PASS -alias server   \
  		-storetype PKCS12 -noprompt
done
  
echo "\nCreate a trust store for brokers with the broker’s CA certificate.\n"  
keytool -import -file ../ca_authority/server.ca.crt -keystore server.ts.p12 \
  -storetype PKCS12 -storepass $SERVER_TRUST_PASS -alias server -noprompt
  
echo "\nGenerate a trust store for clients with the broker’s CA certificate.\n"  
keytool -import -file ../ca_authority/server.ca.crt -keystore ../client_certs/client.ts.p12 \
  -storetype PKCS12 -storepass $CLIENT_TRUST_PASS -alias ca -noprompt

