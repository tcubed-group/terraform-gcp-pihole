#!/bin/bash

# Improved deployment script for Pi-hole on GCP
# Usage: ./scripts/deploy.sh [dev|prod] [destroy]

set -e

function print_header() {
  echo
  echo "============================================"
  echo "$1"
  echo "============================================"
  echo
}

# Default to dev if no environment specified
ENV=${1:-dev}
ACTION=${2:-apply}
VALID_ENVS=("dev" "prod")
VALID_ACTIONS=("apply" "destroy" "plan")

# Validate environment
if [[ ! " ${VALID_ENVS[@]} " =~ " ${ENV} " ]]; then
    echo "Error: Invalid environment '$ENV'. Must be one of: ${VALID_ENVS[*]}"
    exit 1
fi

# Validate action
if [[ ! " ${VALID_ACTIONS[@]} " =~ " ${ACTION} " ]]; then
    echo "Error: Invalid action '$ACTION'. Must be one of: ${VALID_ACTIONS[*]}"
    exit 1
fi

# Base directories for the specified environment
TERRAFORM_DIR="terraform/environments/$ENV"
INVENTORY_DIR="ansible/inventory/$ENV"

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
  echo "Error: terraform is not installed or not in the PATH."
  exit 1
fi

# Destroy infrastructure if requested
if [ "$ACTION" == "destroy" ]; then
  print_header "DESTROYING INFRASTRUCTURE FOR $ENV ENVIRONMENT"
  cd "$TERRAFORM_DIR"
  terraform destroy -auto-approve
  exit 0
fi

# Plan infrastructure if requested
if [ "$ACTION" == "plan" ]; then
  print_header "PLANNING INFRASTRUCTURE FOR $ENV ENVIRONMENT"
  cd "$TERRAFORM_DIR"
  terraform init
  terraform plan
  exit 0
fi

# Check if terraform.tfvars exists, if not copy the example
if [ ! -f "$TERRAFORM_DIR/terraform.tfvars" ]; then
  print_header "SETTING UP TERRAFORM VARIABLES FOR $ENV"
  if [ -f "$TERRAFORM_DIR/terraform.tfvars.example" ]; then
    echo "terraform.tfvars not found. Creating from example..."
    cp "$TERRAFORM_DIR/terraform.tfvars.example" "$TERRAFORM_DIR/terraform.tfvars"
    echo "Please edit $TERRAFORM_DIR/terraform.tfvars with your GCP project details and SSH key path."
    exit 1
  else
    echo "Error: terraform.tfvars.example not found in $TERRAFORM_DIR."
    exit 1
  fi
fi

# Deploy infrastructure with Terraform
print_header "DEPLOYING INFRASTRUCTURE FOR $ENV ENVIRONMENT"
cd "$TERRAFORM_DIR"
terraform init
terraform apply -auto-approve
cd - > /dev/null
