# Using Azure DevOps and Terraform to deploy a high-available AWS EC2 instance 

## What?

This project will assist you to use Azure DevOps pipeline(YAML) and Terraform to deploy an AWS EC2 instance in a Availability-Zone for high availability and resilience.

## Why?

Most organisations still experience silo's when it comes to execution even from a cloud perspective. 
You still have specialised teams within the cloud teams, E.G network, compute etc.
The aim is to help application teams leverage existing resources(VPC and subnets) to deploy their application inrastructure via IaC and DevOps. 

## Which components are deployed:-

	○ AWS EC2 instances in a AZ
  - An EFS instance in a AZ
  - A load balancer


## Prerequisites:-

	○ A running AWS EKS Cluster
	○ AWS ECR(Elastic Container Registry)
	○ AWS Kubernetes service connection
	○ AWS Services Connection
	○ An Azure DevOps account
	○ AWS Toolkit for Azure DevOps
	○ A Github account(or any Git based vcs)
	○ An application to be dockerized and deployed(free to use my sample)


## Repo structure:-

	1. Source folder: contains my python sample app
	2. Root folder:
		○ Dockerfile: used to dockerize my python app
		○ App-manifest: a yaml Kubernetes deployment type(pod), application manifest
		○ Azure-pipelines: This is a multi-stage yaml which contains all the steps required for the pipeline
		○ Requirements: These are the application requirements
	

## Usage:-

You are free to clone the repo and retrofit to your requirements, or you can copy any component but there are modifications required on the Azure-pipeline.

1. AWS Kubernetes service connection
   - https://www.efficientclouds.com/post/how-to-connect-azure-devops-to-eks
2. AWS Services Connection
   - Install AWS Toolkit for Azure DevOps https://aws.amazon.com/vsts/
   - Requires an AWS Access Key ID and Secret Access Keys
   - https://docs.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml 
	
	
3. Azure-pipeline
   - Ensure your repo name presents your app(E.G aws-docker-eks1) - easier to reference during automation

   - Build Stage
      - Authenticates to AWS ECR using my AWS service connection(AWS-Connection-1) 
      - Builds and tags the docker image from the dockerfile 
      - Pushes the image to AWS ECR
      - Copies the App-manifest.yaml to the staging directory for Release

   - Deploy Stage
     - Downloads the App-manifest.yaml for deployment
     - Authenticates and deploys the YAML file to the AWS EKS cluster

## Things to note on the Pipeline and App-manifest

   - I am using the Azure DevOps Predefined variables[$(Build.BuildNumber), $(Build.Repository.Name)] for automation purposes(Image tagging on the YAML deployment & ECR repo) 
   - I am using self-defined variables[$(AWS_REGION), $(ECR_ID)] for automation purposes. 
   - I have also enabled Approvals for EKS deployment(continuous delivery)  


## Ok, so how do you use this for testing without changing a lot??

   - Meet the prerequisites 
   - Change the self-defined variables
   - Change the (kubectl set) "arguments" line 104 on the Azure-pipeline file , to your own ECR repo mage
   - Change the "image" ref line 18 on the app-manifest, to your own ECR repo image

   ECR image repo = $(ECR_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/**siphiwemsibiaws-docker-eks1**:$(Build.BuildNumber) replace with your ECR repo 
    


This is the 1st MVP, proper blog to come soon if the need arises. 
