# Notify with Slack  

This Nebula Workflow sends a message to a Slack channel using the Terraform Slack Step. 

The Workflow is defined in `notify-slack.yml`. 

## Pre-requisites
This Workflow requires configuration of the following secrets: 

| Secret        | Description   | Notes   | 
| ------------- | ------------- | ------- |
| slack-token  | Slack authentication token | [Getting a slack token](https://get.slack.help/hc/en-us/articles/215770388-Create-and-regenerate-API-tokens) |
