# Nebula Workflow Examples  
This repository contains example Workflows for [Project Nebula](https://puppet.com/project-nebula). Feel free to use these Workflows to get started.

## General Example Workflows 
| Workflow      | Description   | 
| ------------- | ------------- |
| [Sample Workflow](./sample-workflow)| Example workflow that models the types of Workflow steps that a user can execute within Nebula |
| [Notify with Slack](./notify-slack)| Sends a message to a Slack channel using the Slack Step. | 

## Cloud Native Application Workflows 
| Workflow      | Description   | 
| ------------- | ------------- |
| [Basic deploy Nodejs app to K8s](./deploy-nodejs-app-to-k8s)| Deploys a basic nodejs app to Kubernetes. It first stands up a mongodb instance using Helm and then creates the Kubernetes deployment using kubectl. |
| [Basic deploy Nodejs app to ECS](./deploy-nodejs-app-to-ecs) | Deploys a basic nodejs app to ECS |
| [Canary deploy Sock Shop app to K8s](./deploy-sockshop-to-k8s) | Deploys the Sock Shop app to Kubernetes and demonstrates canary deployment| 
| [Rolling deploy Voting app to ECS](./deploy-voting-app-to-ecs) | Deploys the Voting App to ECS and demonstrates rolling deployment |
| *STRETCH* Deploy lambda application | Deploy an app to Lambda | 

## Cloud Infrastructure Workflows
| Workflow      | Description   | 
| ------------- | ------------- |
| [Provision GKE cluster with Terraform](./provision-gke-terraform) | Provisions a sample Kubernetes cluster on GKE using Terraform. | 
| [Provision ECS cluster](./provision-ecs-cluster) | Provisions a sample ECS cluster on AWS using Nebula's ECS provisioner. |
| [Provision K8s cluster on AWS EC2 with Helm, Istio](./provision-k8s-cluster-ec2) | Provisions a sample Kubernetes cluster on AWS EC2 instances and configures it with Helm, Istio |

