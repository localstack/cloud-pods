# Cloud Pod — Lambda Event Filtering using SQS & DynamoDB

The code in this directory is from [LocalStack Pro Samples](https://github.com/localstack/localstack-pro-samples/tree/master/lambda-event-filtering). In this sample project, we will develop AWS Lambda event source filtering with DynamoDB and SQS. For this project, we have used AWS Serverless Application Model (SAM), and a thin LocalStack wrapper `samlocal` to create our infrastructure through SAM on LocalStack.

## Prerequisites

- LocalStack
- Docker
- `make`
- `awslocal`

## Cloud Pods

To manually create the Lambda function, navigate to the [LocalStack Pro Samples](https://github.com/localstack/localstack-pro-samples/tree/master/lambda-event-filtering) directory and follow the instructions in the `README.`

On the other hand, you can use Cloud Pods to inject the AWS infrastructure we have already created! To do so, run the following command:

```bash
make run
```

It will load the Lambda function for event source filtering using Cloud Pod (using the [`load`](https://docs.localstack.cloud/user-guide/tools/cloud-pods/pods-cli/#load) command), which consists of an SQS queue and DynamoDB table, deployed via Serverless Application Model (SAM). The above command will load the Cloud Pod, and send a message to the queue, where you can see the Lambda function being triggered.
