#!/bin/bash -e
ls -lha
wget -O "pivotal-gemfire.deb" --post-data="" --header="Authorization: Token ${PIVNET_TOKEN}" https://network.pivotal.io/api/v2/products/pivotal-gemfire/releases/1753/product_files/4635/download
sudo dpkg -i pivotal-gemfire.deb
sudo apt-get update
sudo apt-get -y install default-jre-headless 
gfsh version
gfsh -e "connect --locator=${LOCATOR_CONNECTION}" -e "list members" -e "describe region"
