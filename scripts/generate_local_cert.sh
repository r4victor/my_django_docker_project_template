#!/bin/bash
project_dir=$(dirname $(realpath $(dirname $0)))
ssl_dir=${project_dir}/nginx/etc/ssl/
mkdir -p ${ssl_dir}
openssl req -x509 -out ${ssl_dir}le-crt.pem -keyout ${ssl_dir}le-key.pem \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
cp ${ssl_dir}le-crt.pem ${ssl_dir}le-chain-crt.pem
