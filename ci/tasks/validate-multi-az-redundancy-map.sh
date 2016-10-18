#!/bin/bash -e
ls -lha
echo $OMG_LOCATOR_STATIC_IP
wget -O "pivotal-gemfire.deb" --post-data="" --header="Authorization: Token ${PIVNET_TOKEN}" https://network.pivotal.io/api/v2/products/pivotal-gemfire/releases/1753/product_files/4635/download
sudo dpkg -i pivotal-gemfire.deb
sudp apt-get -y install jre
gfsh version
