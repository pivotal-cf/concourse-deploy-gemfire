#!/bin/bash -e
ls -lha
curl -vs ${REST_API_ENDPOINT} 2>&1
