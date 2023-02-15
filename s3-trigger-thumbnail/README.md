# Tutorial: Using an Amazon S3 trigger to create thumbnail images

The code in this folder replicates [this tutorial](https://docs.aws.amazon.com/lambda/latest/dg/with-s3-tutorial.html) on the official AWS documentation. 
In a nutshell, in this tutorial we are going to create two S3 buckets, a source and a target bucket.
For every image uploaded in the source S3 bucket, an AWS Lambda function will create a thumbnail and upload it in the target bucket.

## Prerequisites

* LocalStack
* Docker
* `make`
* `awslocal`
* Node.js v.14
* `npm`

## Installing 

To install the dependencies:

```
make install
```

## Create the state

Run the following command will create the state of the application with all its components.

```
make create-state
```

## Trigger the lambda

You can now upload an image in the source S3 bucket with the command:

```
awslocal s3 cp pikachu.jpg s3://img-bucket
```

The AWS Lambda will be triggered and it will create a new image called `resized-pikachu.jpg` into the `img-bucket-resized` bucket.

You can inspect such a bucket as follows:

```
awslocal s3 ls s3://img-bucket-resized
```

## Cloud Pods

Instead of manually creating each resource, you can inject the public Cloud Pods named `thumbnail-qs` and achieve the same result.
To do so, run the following command

```
localstack pod pull --name thumbnail-qs
```