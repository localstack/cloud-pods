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
	repoUri=$$(awslocal ecr create-repository --repository-name iris-machine-learning-tutorial | jq -r '.repository.repositoryUri'); \
	docker build -t "$$repoUri" .;\
	docker push "$$repoUri"; \
	awslocal lambda create-function --function-name iris-prediction --package-type Image \
		--code ImageUri=$$repoUri \
		--role arn:aws:iam::000000000:role/lambda-r1 \
		--handler lambda_function.lambda_handler;

test:
	awslocal lambda invoke --function-name iris-prediction \
		--cli-binary-format raw-in-base64-out --payload '{"values":[[5.9,3.0,5.1,2.3]]}' output.txt
	cat output.txt
