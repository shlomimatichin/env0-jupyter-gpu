#!/bin/bash
set -e

BASE_AMI_NAME=${BASE_AMI_NAME:-"Deep Learning AMI (Ubuntu 18.04) Version 28.0"}
AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-"eu-central-1"}
export AWS_DEFAULT_REGION

echo "Querying AMI id for an image named '$BASE_AMI_NAME'"
echo "AWS region: $AWS_DEFAULT_REGION"

if [ ! -f jq ]; then
    echo "Downloading jq"
    curl --location -o jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
    echo "Done downloading jq"
    chmod 755 jq
fi

echo "Querying AMI ID from by image name"
BASE_AMI_ID=$(aws ec2 describe-images --owners amazon --filters "Name=name,Values=Deep Learning AMI (Ubuntu 18.04) Version 28.0" | ./jq '.Images[0].ImageId' -r)
echo "Base AMI ID: $BASE_AMI_ID"

if [ ! -f packer.zip ]; then
    echo "Downloading packer"
    curl --location -o packer.zip https://releases.hashicorp.com/packer/1.5.6/packer_1.5.6_linux_amd64.zip
    echo "Done downloading packer"
fi
unzip -o packer.zip

./packer build -var "base_ami_id=$BASE_AMI_ID" jupyter.packer.json
