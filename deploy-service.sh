#!/bin/sh
echo $1
if [ -z ${1+x} ]; then
  echo "You'll have to specify a cluster. ie ./deploy-service.sh my-cluster"
else
  aws cloudformation deploy --template-file deployment/task.yml --stack-name spot-checker --capabilities CAPABILITY_IAM
  # TASK=$(aws cloudformation describe-stack-resources \
  #   --stack-name spot-checker \
  #   --query 'StackResources[?LogicalResourceId==`Task`].PhysicalResourceId' \
  #   --output text)
  # aws ecs update-service --cluster $1 \
  #   --service spot-checker \
  #   --desired-count 100 \
  #   --task-definition $TASK \
  #   --deployment-configuration maximumPercent=100,minimumHealthPercent=0 \
  #   --
fi
