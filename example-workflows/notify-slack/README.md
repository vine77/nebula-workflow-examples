# Notify with Slack  

This Nebula workflow sends a message to a Slack channel using the Slack step.

The workflow is defined in `notify-slack.yml`.

<p align="center"><img src="./notify-slack.png" alt="Slack Workflow"></p>


## Pre-requisites
Configure the following secrets:

| Secret        | Description   | Notes   |
| ------------- | ------------- | ------- |
| slack-token  | Slack authentication token | [Getting a slack token](https://get.slack.help/hc/en-us/articles/215770388-Create-and-regenerate-API-tokens) |

Set `channel` to an existing Slack channel.

Edit `message` to personalize your notification message.