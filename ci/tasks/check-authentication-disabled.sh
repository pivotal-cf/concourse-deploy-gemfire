#!/bin/bash -e
ls -lha
sudo apt-get update
sudo apt-get -y install default-jre-headless 
cd gemfire-testapp
./mvnw clean package -DskipTests=true
java -jar target/CMSClient-0.0.1-SNAPSHOT.jar --gemfire.locator.host=${LOCATOR_TEST_IP} —gemfire.locator.port=${LOCATOR_TEST_PORT}
