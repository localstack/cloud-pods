# Cloud Pod — Scrape GitHub Trending repositories using Lambda

The code in this directory is from [LocalStack Pro Samples](https://github.com/localstack/localstack-pro-samples/tree/master/lambda-function-urls/python). In this sample project, we create an AWS Lambda function that scrapes trending GitHub repositories and sends the results as a JSON response using the Lambda function URL. With the Function URL property, there is now a new way to call a Lambda Function via HTTP API call.

## Prerequisites

- LocalStack
- Docker
- `make`
- `awslocal`

## Cloud Pods

To manually create the Lambda function, navigate to the [LocalStack Pro Samples](https://github.com/localstack/localstack-pro-samples/tree/master/lambda-function-urls/python) directory and follow the instructions in the `README.`

On the other hand, you can use Cloud Pods to inject the AWS infrastructure we have already created! To do so, run the following command:

```bash
make run
```

It will load the `lambda-url` Cloud Pod (using the [`load`](https://docs.localstack.cloud/user-guide/tools/cloud-pods/pods-cli/#load) command), which consists of a Lambda function and an associated URL configured via Function URLs. The above command will fetch the Lambda Function URL and send an HTTP request to display the trending repositories.
