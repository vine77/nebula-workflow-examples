# Deploy Sock Shop app to Kubernetes

This Nebula Workflow deploys the classic [Sock Shop app](https://github.com/microservices-demo/microservices-demo) to K8s. In this example, I'd like to show a canary deployment to Kubernetes by incrementally modifying an ingress k8s object. Here's a blog post outlining this approach: https://istio.io/blog/2017/0.1-canary/. 

We could:
1. Deploy the sock shop app
2. Wait 10 seconds 
3. Deploy another version of the sock shop front end 
4. Use Istio to perform canary deployment - Increase traffic to 10% 
5. Wait 10 seconds
6. Increase traffic to 50% 
7. Wait 10 seconds 
8. Increase traffic to 100% 

The Workflow is defined in `workflow.yml`.

## Pre-requisites
This Workflow assumes that you have a publicly accessible Kubernetes cluster. 