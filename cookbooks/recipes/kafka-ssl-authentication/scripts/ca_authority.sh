#!/bin/bash
set -e

mkdir -p "$(dirname $0)/ca_authority"
cd "$(dirname $0)/ca_authority"

SERVER_CN="${CA_SERVER_AUTHORITY_CN}"
CLIENT_CN="${CA_CLIENT_AUTHORITY_CN}"
CA_SERVER_KEY_PASS="${CA_SERVER_KEY_PASS}"
CA_CLIENT_KEY_PASS="${CA_CLIENT_KEY_PASS}"

if [ -z "$CA_SERVER_KEY_PASS" ]
then
      echo "Please set CA_SERVER_KEY_PASS environment variable."
      exit 1;
fi

if [ -z "$SERVER_CN" ]
then
      echo "CA_SERVER_AUTHORITY_CN is empty, please set the CA_SERVER_AUTHORITY_CN environment variable"
      exit 1;
else
      echo "/CN=$SERVER_CN"

      keytool -genkeypair -keyalg RSA -keysize 2048 -keystore server.ca.p12        \
          -storetype PKCS12 -storepass $CA_SERVER_KEY_PASS -keypass $CA_SERVER_KEY_PASS  \
          -alias ca -dname "CN=$SERVER_CN" -ext bc=ca:true -validity 365
      keytool -export -file server.ca.crt -keystore server.ca.p12 \
          -storetype PKCS12 -storepass $CA_SERVER_KEY_PASS -alias ca -rfc
fi

if [ -z "$CLIENT_CN" ]
then
      echo "CA_CLIENT_AUTHORITY_CN is empty, not generating the client certificate authority (CA)"
      exit 1;
else

	if [ -z "$CA_CLIENT_KEY_PASS" ]
	then
      	echo "Please set CA_CLIENT_KEY_PASS environment variable."
      	exit 1;
	fi

      	echo "/CN=$CLIENT_CN"

	  	keytool -genkeypair -keyalg RSA -keysize 2048 -keystore client.ca.p12         \
    		-storetype PKCS12 -storepass $CA_CLIENT_KEY_PASS -keypass $CA_CLIENT_KEY_PASS \
  			-alias ca -dname CN=ClientCA -ext bc=ca:true -validity 365
		keytool -export -file client.ca.crt -keystore client.ca.p12  -storetype PKCS12 \
  			-storepass $CA_CLIENT_KEY_PASS -alias ca -rfc
fi
