# Tutorial: Using Amazon Lambda and ECS to predict Iris species using Scikit-Learn

In this tutorial, you’ll learn how to create a serverless Lambda function, deployed as a container image, to predict Iris species using Scikit-Learn. This tutorial is intended for Pro users who wish to get more acquainted with Lambda, ECS, and LocalStack's Cloud Pods for reproducible machine learning.

## Prerequisites

* LocalStack
* Docker
* `make`
* `awslocal`

## Installing

To install the dependencies:

```sh
make install
```

## Create a container image

Create an ECR repository:

```sh
awslocal ecr create-repository --repository-name iris-machine-learning-tutorial | jq -r '.repository.repositoryUri'
```

Build the container image:

```sh
docker build -t localhost:4510/iris-machine-learning-tutorial .
```

Push the container image to the repository:

```sh
docker push localhost:4510/iris-machine-learning-tutorial:latest
```

## Create the Lambda function

Create the Lambda function:

```sh
awslocal lambda create-function --function-name iris-prediction --package-type Image \
		--code ImageUri=localhost:4510/repo1 --role arn:aws:iam::000000000:role/lambda-r1 \
		--handler lambda_function.lambda_handler
```

Test the Lambda function:

```sh
awslocal lambda invoke --function-name iris-prediction \
		--cli-binary-format raw-in-base64-out --payload '{"values":[[5.9,3.0,5.1,2.3]]}' output.txt
```

The `output.txt` file should contain the following output:

```json
{"body":"[\"Iris-virginica\"]","statusCode":200}
```

## Create a Cloud Pod

Commit your Pod state:

```sh
localstack pod commit --name iris-cloud-pod --message "<commit-message>"
```

Check your current Pods:

```sh
localstack pod list
```

Push your Pod to the remote provider:

```sh 
localstack pod push --name iris-cloud-pod --message "<message>"
```

Delete your local Pod and stop your LocalStack instance

```sh
localstack pod delete --name iris-cloud-pod --local
make stop
```

Start your LocalStack instance and pull your Pod from the remote provider:

```sh
make start
localstack pod pull --name iris-cloud-pod
```

Run the Lambda function test once again.