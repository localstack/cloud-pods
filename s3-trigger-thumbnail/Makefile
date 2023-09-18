export AWS_ACCESS_KEY_ID ?= test
export AWS_SECRET_ACCESS_KEY ?= test
export AWS_DEFAULT_REGION ?= us-east-1

usage:      ## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

install:    ## Install dependencies
	@which localstack || pip install localstack
	@which awslocal || pip install awscli-local

create-state:   ## Create Cloud Pod
	@./script.sh

upload:   # Upload image to trigger Lambda function
	awslocal s3 cp pikachu.jpg s3://img-bucket

s3-list:  # List bucket contents
	awslocal s3api list-objects --bucket img-bucket
	awslocal s3api list-objects --bucket img-bucket-resized

clean:    # Clean build output
	rm -f lambda-s3/function.zip
	rm -rf lambda-s3/node_modules

.PHONY: usage install create-state upload s3-list clean
