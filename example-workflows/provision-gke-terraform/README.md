# Provision GKE cluster 

This Nebula workflow provisions a sample Kubernetes cluster on GKE using Terraform. 

The workflow is defined in `workflow.yaml`.

> **Note** You must run this workflow from the `master` branch.

<p align="center"><img src="../../media/provision-k8s-cluster.png" alt="Provision GKE cluster"></p>

## Pre-requisites

Before you run this workflow, create a Google Cloud
Project (GCP) storage bucket named `demo-sandbox-123`. This is where Terraform
stores the state files for your cluster. Make sure that you have a
service account with storage access to the bucket.

> **Note:** If you would prefer to use a different bucket, change the
> `bucket` value in [main.tf](https://github.com/puppetlabs/nebula-workflow-examples/blob/master/example-workflows/provision-gke-terraform/infra/main.tf) to the name of your bucket. For example, `bucket = "my-bucket"`

Configure the following secrets:

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
- name: provision-gke-with-terraform
  image: projectnebula/terraform:bf8ecb9
  spec:
    vars:
      gcp_region: us-east1
      gcp_location: us-east1-b
      gcp_project: kenazk-sandbox
    workspace: nebula-demo
    directory: provision-gke-terraform/infra/
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

Use `gcp_region`, `gcp_location` to change the target GCP location for the cluster.

Replace `gcp_project` with the name of your GCP project. This is where the
  step will deploy the cluster.
 
 ### Step 3 Notify with Slack
 If the provisioning step succeeds, this step creates a Slack notification and
 sends it to a Slack channel.

 ```
- name: slack-notify
  image: projectnebula/slack-notification:bf8ecb9
  spec:
    apitoken:
      $type: Secret
      name: slack-token
    channel: "#nebula-workflows"
    message: "Provisioning K8s with Terraform succeeded! Good job everyone."
  dependsOn:
  - provision-gke-with-terraform
  ```

Set `channel` to an existing Slack channel.

Edit `message` to personalize your notification message.
