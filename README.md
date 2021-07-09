# Using Azure DevOps and Terraform to deploy a high-available AWS EC2 instance

## What?

This project will assist you to use Azure DevOps pipeline(YAML) and Terraform to deploy an AWS EC2 instance in a Availability-Zone for high availability and resilience.

## Why?

Most organisations still experience silo's when it comes to execution even from a cloud perspective.
You still have specialised teams within the cloud teams, E.G network, compute etc.
The aim is to help application teams leverage existing resources(VPC and subnets) to deploy their application infrastructure via IaC and DevOps.

## Which components are deployed:-

- AWS EC2 instances in a AZ
- An EFS instance in a AZ
- A load balancer
- Security groups
- EBS volumes

## Prerequisites:-

- AWS Services Connection
- AWS for Terraform Services Connection
- A Github account(or any Git based vcs)
- An Azure DevOps account
- An existing S3 to store terraform code
- An existing VPC and Subnets
- Some understanding of Azure DevOps, AWS and terraform

## Usage:-

You are free to clone the repo and retrofit to your own requirements. Individual component code(E.G efs.tf) can be reused as modules.
I have tried explaining some of the things withing the specific files

1. AWS & AWS for Terraform Services Connection
   - Install AWS Toolkit for Azure DevOps <https://aws.amazon.com/vsts/>
   - Requires an AWS Access Key ID and Secret Access Keys
   - <https://docs.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml>

2. Azure DevOps
   - Represented by the azure-pipelines.yml
   - Modify the environmentServiceNameAWS & backendServiceAWS to your own service connections  
   - The pipeline must point to your own repo
   - Terraform is used to plan & deploy the code whenever you commit code to the repo

3. Variables
Most important file, where you can specify your own environmental variables.
   - Notably vpc_id, subnets, subnet_ids

## Gotcha:-

At the time of this writing(07-07-2021)

- Struggled with the "AWS Services Connection" as I was trying to create my terraform state file in South Africa(af-south-1) region. This gave me errors.
- I only succeeded by using the us-east-1 region for storing the tf state file.
