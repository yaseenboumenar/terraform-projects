#!/bin/bash

IMAGE_NAME="wordpress-challenge-wordpress-ec2"

echo "🔍 Scanning $IMAGE_NAME for vulnerabilities..."

trivy image --exit-code 1 --severity HIGH,CRITICAL $IMAGE_NAME

if [ $? -eq 1 ]; then
    echo "❌ Vulnerabilities found!"
    exit 1
else
    echo "✅ No critical vulnerabilities found!"
fi