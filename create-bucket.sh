#!/bin/sh

echo -n "Please enter a unique name for your S3 bucket and press [ENTER]: "
read REGL_BUCKET
echo "" | awk '{print $1}'

echo "Creating S3 buckets as backup targets"

aws s3 mb s3://$REGL_BUCKET --region us-west-2
