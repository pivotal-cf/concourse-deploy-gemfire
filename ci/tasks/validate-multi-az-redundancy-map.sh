#!/bin/bash -e
ls -lha
wget -O "pivotal-gemfire.deb" --post-data="" --header="Authorization: Token ${PIVNET_TOKEN}" https://network.pivotal.io/api/v2/products/pivotal-gemfire/releases/1753/product_files/4635/download
sudo dpkg -i pivotal-gemfire.deb
sudo apt-get update
sudo apt-get -y install default-jre-headless 
gfsh version
gfsh \
-e "connect --locator=${LOCATOR_CONNECTION}" \
-e "list members" \
-e "create region --name=testing --redundant-copies=1 --type=PARTITION_REDUNDANT" \
-e "show metrics --categories=partition --region=testing" > gemfire-output.txt
cat gemfire-output.txt
# checks redundancy in regions using the suggested method from pivotal docs: 
# http://gemfire.docs.pivotal.io/docs-gemfire/latest/developing/partitioned_regions/checking_region_redundancy.html
cat gemfire-output.txt | grep numBucketsWithoutRedundancy | grep "| 0"
