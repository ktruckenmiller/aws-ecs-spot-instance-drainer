# aws-ecs-spot-instance-drainer
Deploy an ECS Service onto your cluster called `spot-checker`.

This service will check the underlying spot instance within the cluster to automatically drain the container instances in case of an impending spot instance termination.

## To deploy
`./deploy-service.sh <your-ecs-cluster-name>`

### A Word of Advice

Instead of doing this, it would probably be better to listen to [CloudTrail API calls that are terminating the instances](https://aws.amazon.com/about-aws/whats-new/2016/09/aws-cloudtrail-now-records-amazon-ec2-spot-instances-launch-and-termination-events/) in the ECS cluster. You'd probably want to do this instead of running a service on your cluster, because it's less overhead. The only issue is the complexity in such a deploy. For every ECS cluster that you deploy with a spot fleet, you must tag the EC2 instances with the proper `cluster` identifier. On the ECS side, you'll set an ECS `attribute` instance id when the instance starts. This will logically link them together when you get an instance termination event from CloudTrail.

With the CloudTrail lambda function draining the nodes, for every spot instance termination you're going to want to list the tags of the instance that's being terminated. It will then list the cluster on the tag. From the cluster name, you will then perform an ECS query that asks for the instance id in the ECS attribute. It will allow you to perform a DRAINING on that specific ECS instance.

That seems a lot more elegant as it is event based and non polling. The 2-3 API calls will be very fast and performant compared to the constant daemon service that needs to be running on your infrastructure.
