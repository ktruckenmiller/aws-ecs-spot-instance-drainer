# aws-ecs-spot-instance-drainer
Deploy an ECS Service onto your cluster called `spot-checker`.

This service will check the underlying spot instance within the cluster to automatically drain the container instances in case of an impending spot instance termination.

## To deploy
`./deploy-service.sh <your-ecs-cluster-name>`
