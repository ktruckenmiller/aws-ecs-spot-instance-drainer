#!/bin/sh
docker build -t ktruckenmiller/aws-ecs-spot-checker .
docker push ktruckenmiller/aws-ecs-spot-checker
