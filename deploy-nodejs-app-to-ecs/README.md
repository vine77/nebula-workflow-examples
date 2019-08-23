# Deploy NodeJS app to ECS

This Nebula Workflow deploys a basic nodejs app to K8s. It first stands up a `mongodb` instance and then creates the ECS deployment. 

The Workflow is defined in `workflow.yml`.

## Pre-requisites
This Workflow requires configuration of the following secrets: