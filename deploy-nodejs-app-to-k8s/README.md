# Deploy NodeJS app to Kubernetes

This Nebula Workflow deploys a basic nodejs app to K8s. It first stands up a `mongodb` instance using Helm and then creates the Kubernetes deployment using kubectl. 

The Workflow is defined in `deploy-nodejs-app-to-k8s.yml`.

*NOTE: For simplification, mongodb credentials have been hardcoded into Workflow file for illustration. You shouldn't do this for real.* 

<h4 align="center"><img src="../media/deploy-nodejs-app-to-k8s.png" alt="Deploy Nodejs App to K8s Workflow"></h4>

## Pre-requisites
This Workflow assumes that you have a publicly accessible Kubernetes cluster. 

This Workflow requires configuration of the following secrets:

| Secret        | Description   | Notes   | 
| ------------- | ------------- | ------- |
| credentials   | base64 encoded GCP service account key file  | [More information on key files](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) |
| url           | Kubernetes Cluster URL | Provided a local `kubeconfig` exists, use `$ kubectl config view --raw -o json \| jq -r '.clusters[0].cluster.server'` to grab URL of the cluster. |
| cadata        | Base64 encoded certificate authority data | Provided a local `kubeconfig` exists, use `$ kubectl config view --raw -o json \| jq -r '.clusters[0].cluster."certificate-authority-data"'` to retrieve the certificate-authority-data value. |
| token         | Base64 encoded access token of the user or service account | For info on getting this token, check out this [tutorial](https://gist.github.com/kenazk/cfce793d7ec29b876acaf3d629c3345c)|
| slack-token   | Slack authentication token | [Getting a slack token](https://get.slack.help/hc/en-us/articles/215770388-Create-and-regenerate-API-tokens) |

