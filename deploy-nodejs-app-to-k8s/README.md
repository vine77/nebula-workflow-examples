# Deploy NodeJS app to Kubernetes

This Nebula Workflow deploys a basic nodejs app to K8s. It first stands up a `mongodb` instance using Helm and then creates the Kubernetes deployment using kubectl. 

The Workflow is defined in `deploy-nodejs-app-to-k8s.yml`.

<h4 align="center"><img src="../media/deploy-nodejs-app-to-k8s.png" alt="Deploy Nodejs App to K8s Workflow"></h4>

## Pre-requisites
This Workflow assumes that you have a publicly accessible Kubernetes cluster. 

This Workflow requires configuration of the following secrets:

| Secret        | Description   | Notes   | 
| ------------- | ------------- | ------- |
| url           | Kubernetes Cluster URL | Provided a local `kubeconfig` exists, use `$ kubectl config view --raw -o json \| jq -r '.clusters[0].cluster.server'` to grab URL of the cluster. *NOTE: [jq](https://stedolan.github.io/jq/) is needed as a prerequisite.* |
| cadata        | Base64 encoded certificate authority data | Provided a local `kubeconfig` exists, use `$ kubectl config view --raw -o json \| jq -r '.clusters[0].cluster."certificate-authority-data"'` to retrieve the certificate-authority-data value. *NOTE: [jq](https://stedolan.github.io/jq/) is needed as a prerequisite.* |
| token         | Base64 encoded access token of the user or service account | For info on getting this token, check out this [tutorial](https://gist.github.com/kenazk/cfce793d7ec29b876acaf3d629c3345c)|
| slack-token   | Slack authentication token | [Getting a slack token](https://get.slack.help/hc/en-us/articles/215770388-Create-and-regenerate-API-tokens) |

## What's happening

### Step 1 Init
This is an example step of any initial activities you might want to do before deploying the application.

### Step 2 Helm deploy mongodb
In this step, we deploy a mongodb instance onto a Kubernetes cluster using Helm to deploy the latest mongo Helm chart. The Helm Nebula step is configured as follows: 
```
- name: deploy-mongodb
  image: gcr.io/nebula-tasks/nebula-helm-deployer:57d9f2b
  spec:
    values:
      mongodbRootPassword: mongo-password
      mongodbUsername: mongo-user
      mongodbPassword: mongo-password
      mongodbDatabase: mongo-database
    name: mongo
    chart: stable/mongodb
    namespace: default
    cluster:
      name: nebula-demo-cluster
      url:
        $type: Secret
        name: url
      cadata:
        $type: Secret
        name: cadata
      token:
        $type: Secret
        name: token
  dependsOn:
    - init-workflow
```
Kubernetes cluster is specified in the Step using the `name`, `url`, `cadata`, and `token`. 

*NOTE: For simplification, mongodb credentials have been hardcoded into Workflow file for illustration. You shouldn't do this for real.* 

### Step 3 kubectl deploy nodejs app
In this step, we deploy the nodejs app to the cluster using the kubectl Nebula step. The step is configured as follows: 
```
- name: deploy-nebula-demo
  image: gcr.io/nebula-tasks/nebula-kubectl:57d9f2b
  spec:
    command: apply
    file: deploy-nodejs-app-to-k8s/deploy/nebula-demo.yaml
    namespace: default
    cluster:
      name: nebula-demo-cluster
      url:
        $type: Secret
        name: url
      cadata:
        $type: Secret
        name: cadata
      token:
        $type: Secret
        name: token
    git:
      name: nebula-workflow-examples
      repository: https://github.com/puppetlabs/nebula-workflow-examples.git
  dependsOn:
  - deploy-mongodb
  ```
 
 ### Step 4 Notify with Slack
 Based on the successful deployment of the nodejs app, we notify in slack using the Nebula Slack step that provisioning has succeeded: 
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
