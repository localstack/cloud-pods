export AWS_ACCESS_KEY_ID ?= test
export AWS_SECRET_ACCESS_KEY ?= test
export AWS_DEFAULT_REGION = us-east-1

usage:       ## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

install:     ## Install dependencies
	@which awslocal || pip install awscli-local

start:
	localstack start -d

stop:
	@echo
	localstack stop

ready:
	@echo Waiting on the LocalStack container...
	@localstack wait -t 30 && echo Localstack is ready to use! || (echo Gave up waiting on LocalStack, exiting. && exit 1)

logs:
	@localstack logs > logs.txt

run:
	echo "Running the Lambda Event Filtering Example"; \
	localstack pod load file:///Users/harshcasper/code/localstack/cloud-pods/lambda-event-filtering/lambda-event-filtering; \
	sleep 5; \
	echo "Invoking the Lambda Function by sending a SQS message"; \
	awslocal sqs send-message --queue-url http://localhost:4566/000000000000/MyQueue --message-body "{ "data" : "A" }" --delay-seconds 10
