#!/bin/bash

awslocal s3 mb s3://img-bucket
awslocal s3 mb s3://img-bucket-resized

awslocal iam create-role --role-name lambda-role \
    --assume-role-policy-document file://role.json 

cd lambda-s3
docker run --rm -v "$(pwd):/app" -w /app node:16 npm install --arch=x64 --platform=linux
zip -r function.zip .
cd ..

awslocal lambda create-function --function-name CreateThumbnail \
    --zip-file fileb://lambda-s3/function.zip --handler index.handler --runtime nodejs16.x \
    --timeout 10 --memory-size 1024 \
    --role arn:aws:iam::000000000000:role/lambda-role
awslocal lambda wait function-active-v2 --function-name CreateThumbnail

awslocal lambda update-function-configuration --function-name CreateThumbnail --timeout 30
awslocal lambda wait function-updated-v2 --function-name CreateThumbnail

awslocal s3api put-bucket-notification-configuration \
    --bucket img-bucket --notification-configuration file://configuration.json

awslocal lambda get-function --function-name CreateThumbnail
