# Terraform AWS NGINX + kitchen-tf example

This repository contains terraform code that creates an AWS EC2 instance running NGINX + Kitchen terraform test

## Prerequisites:
1. AWS account
2. SSH Keypair
3. (optional) [The AMI build during the packer-aws-nginx excercise](https://github.com/qwerty1979bg/packer2-aws-gninx)

## Usage

1. [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)
2. Clone this repository and `cd` into it.
3. Run the following:

Manual Terraform:
```
$ export TF_VAR_aws_access_key=<YOUR AWS ACCESS KEY>
$ export TF_VAR_aws_secret_key=<YOUR AWS SECRET KEY>
$ export TF_VAR_key_name=<THE NAME OF YOUR SSH KEY>
(optional) $ export TF_VAR_ami_name=<THE NAME OF YOUR NGINX AMI>
$ terraform init
$ terraform apply
$ terraform destroy
```

Automatic kitchen-terraform test:
```
$ brew install rbenv
$ rbenv local 2.3.1
$ gem install bundler
$ bundle install
$ kitchen test
```
