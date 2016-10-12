#!/bin/bash -e

chmod +x omg-cli/omg-linux

omg-cli/omg-linux register-plugin \
  -type product \
  -pluginpath omg-product-bundle/$PRODUCT_PLUGIN

omg-cli/omg-linux deploy-product \
  --bosh-url $BOSH_URL \
  --bosh-port $BOSH_PORT \
  --bosh-user $BOSH_CLIENT \
  --bosh-pass $BOSH_CLIENT_SECRET \
  --print-manifest \
  --ssl-ignore \
  $PRODUCT_PLUGIN \
  --deployment-name $DEPLOYMENT_NAME \
  --stemcell-ver $STEMCELL_VERSION > manifest/deployment.yml

#eof
