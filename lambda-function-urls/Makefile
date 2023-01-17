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
	echo "Load the Cloud Pod to inject a Lambda function that scraps GitHub trending page"; \
	localstack pod load git://localstack/cloud-pods/lambda-function-urls/lambda-url; \
	sleep 5; \
	echo "Fetch the Lambda URL to send a request to fetch us the trending repositories"; \
	url=$$(awslocal lambda get-function-url-config --function-name trending | jq -r '.FunctionUrl'); \
	echo "Send a request to the Lambda URL to display the trending repositories"; \
	curl -s $$url | jq .; \
	echo "Done — Repositories have been successfully fetched."
