#!/bin/bash

docker build -f Dockerfile -t jenkins201/hashicorp-ci .
docker push jenkins201/hashicorp-ci:latest
