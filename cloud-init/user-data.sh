#!/bin/bash

# Get the variables from Terraform
ENVIRONMENT="${ENVIRONMENT}"
PROJECT_NAME="${PROJECT_NAME}"
APPLICATION_NAME="${APPLICATION_NAME}"
APPLICATION_VERSION="${APPLICATION_VERSION}"

# Create a hello world message with environment info
echo "Hello, World from $APPLICATION_NAME!" > /root/hello.txt
echo "Environment: $ENVIRONMENT" >> /root/hello.txt
echo "Project: $PROJECT_NAME" >> /root/hello.txt
echo "Deployment Time: $(date)" >> /root/hello.txt
echo "Version: $APPLICATION_VERSION" >> /root/hello.txt

# Set up some basic system tags
echo "$ENVIRONMENT" > /etc/environment_tag
echo "$PROJECT_NAME" > /etc/project_tag
echo "$APPLICATION_NAME" > /etc/application_tag
echo "$APPLICATION_VERSION" > /etc/version_tag