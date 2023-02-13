#!/bin/bash

awslocal s3api create-bucket --bucket localwishes

awslocal s3api put-bucket-policy --bucket localwishes --policy file://bucket_policy.json

awslocal s3 sync ./ s3://localwishes

awslocal s3 website s3://localwishes/ --index-document index.html

echo "visit http://localwishes.s3-website.localhost.localstack.cloud:4566/"
