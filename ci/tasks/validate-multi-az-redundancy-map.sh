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
-e "put --key=('1') --value=('A') --region=testing" \
-e "put --key=('2') --value=('B') --region=testing" \
-e "put --key=('3') --value=('C') --region=testing" \
-e "put --key=('4') --value=('D') --region=testing" \
-e "put --key=('5') --value=('E') --region=testing" \
-e "put --key=('6') --value=('F') --region=testing" \
-e "put --key=('7') --value=('G') --region=testing" \
-e "put --key=('8') --value=('H') --region=testing" \
-e "describe config --member=cacheserver-0" \
-e "describe config --member=cacheserver-1" \
-e "describe config --member=cacheserver-2" \
-e "describe config --member=cacheserver-3" \
-e "describe config --member=cacheserver-4" \
-e "describe config --member=cacheserver-5" \
-e "show metrics --categories=partition --region=testing" > gemfire-output.txt
cat gemfire-output.txt
# checks redundancy in regions using the suggested method from pivotal docs:
# http://gemfire.docs.pivotal.io/docs-gemfire/latest/developing/partitioned_regions/checking_region_redundancy.html
cat gemfire-output.txt | grep numBucketsWithoutRedundancy | grep "| 0" &&
cat gemfire-output.txt | grep redundancy-zone | grep ": AZ1" &&
cat gemfire-output.txt | grep redundancy-zone | grep ": AZ2" &&
cat gemfire-output.txt | grep redundancy-zone | grep ": AZ3"
