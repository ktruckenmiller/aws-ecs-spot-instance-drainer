
build:
	docker build -t ktruckenmiller/aws-ecs-spot-checker .
	docker push ktruckenmiller/aws-ecs-spot-checker


develop:
	EC2METADATA_URL=0.0.0.0:51678 go run main.go
	# SPOT_ACTION=404 node index.js
