# AWS S3 Static Website Hosting with Terraform

This project deploys a static website on AWS S3 using Terraform. It provisions the S3 bucket configured for static website hosting, applies appropriate bucket policies for public access, and automates the deployment of static website files.

## Features
- S3 bucket with static website configuration
- Bucket policy to allow public read access
- Terraform automation for repeatable infrastructure setup

## Usage
1. Clone repository
2. Configure AWS credentials
3. `terraform init && terraform apply`
4. Access the website via the S3 website endpoint

## Learning Outcomes
- Infrastructure as Code for serverless static hosting
- AWS S3 bucket policies and website configuration
