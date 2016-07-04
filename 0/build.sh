#!/bin/bash

docker build -t svenahlfeld/rediscluster:v3.0 .
docker push svenahlfeld/rediscluster:v3.0
