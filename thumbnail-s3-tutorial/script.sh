#!/bin/bash

awslocal s3 mb s3://img-bucket
awslocal s3 mb s3://img-bucket-resized

awslocal iam create-role --role-name tut-role \
    --assume-role-policy-document file://role.json 

cd lambda-s3
npm install sharp
zip -r function.zip .

awslocal lambda create-function --function-name CreateThumbnail \
    --zip-file fileb://lambda-s3/function.zip --handler index.handler --runtime nodejs14.x \
    --timeout 10 --memory-size 1024 \
    --role arn:aws:iam::000000000000:role/tut-role

awslocal lambda update-function-configuration --function-name CreateThumbnail --timeout 30

awslocal s3api put-bucket-notification-configuration \
    --bucket img-bucket --notification-configuration file://configuration.json