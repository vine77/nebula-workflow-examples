# Provision GKE cluster 

This Nebula Workflow provisions a sample Kubernetes cluster on GKE. 

The Workflow is defined in `workflow.yaml`.

<h4 align="center"><img src="../media/provision-k8s-cluster.png" alt="Provision GKE cluster"></h4>

## Pre-requisites
This Workflow requires configuration of the following secrets:

| Secret        | Description   | Notes   | 
| ------------- | ------------- | ------- |
| credential    | Base64 encoded GCP service account key | [Details on getting a service account key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) |
| slack-token   | Slack authentication token | [Getting a slack token](https://get.slack.help/hc/en-us/articles/215770388-Create-and-regenerate-API-tokens) |

## What's happening

### Step 1 Init
This is an example step of any initial activities you might want to do before creating the cluster.

### Step 2 Provision GKE cluster
In this step, we deploy a Kubernetes cluster on GKE using the Terraform step. The Terraform step is configured as follows: 
```
- name: provision-nebula-demo
  image: gcr.io/nebula-tasks/nebula-terraform:57d9f2b
  spec:
    vars:
      gcp_region: us-east1
      gcp_location: us-east1-b
      gcp_project: kenazk-sandbox
    workspace: nebula-demo
    directory: provision-gke-cluster/infra/
    credentials:
      credentials.json:
        $type: Secret
        name: credentials
    git:
      name: nebula-workflow-examples
      repository: https://github.com/puppetlabs/nebula-workflow-examples.git
  dependsOn:
  - init-workflow
```
**Notes:**
- You must have a GCP bucket called `sandbox` for this example. This is where the Workflow stores the Terraform state file. 
- `gcp_region`, `gcp_location` can be used to change the target GCP location for the cluster
- `gcp_project` identifies which GCP project to deploy under. 
 
 ### Step 3 Notify with Slack
 Based on the successful provisioning of the cluster, we notify in slack using the Nebula Slack step that provisioning has succeeded: 
 ```
 - name: slack-notify
  image: gcr.io/nebula-tasks/nebula-slack-notification:57d9f2b
  spec:
    apitoken:
      $type: Secret
      name: slack-token
    channel: "#nebula-workflows"
    message: "Provisioning succeeded! Good job everyone."
  dependsOn:
  - provision-nebula-demo
  ```
