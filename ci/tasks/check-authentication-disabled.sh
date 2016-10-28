#!/bin/bash -e
ls -lha
cd gemfire-testapp/CMSClient
./mvnw clean package -DskipTests=true
java -jar target/CMSClient-0.0.1-SNAPSHOT.jar --gemfire.locator.host=${LOCATOR_TEST_IP} —gemfire.locator.port=${LOCATOR_TEST_PORT}
