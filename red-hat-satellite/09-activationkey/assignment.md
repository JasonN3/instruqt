---
slug: activationkey
type: challenge
title: Create an Activation Key
teaser: Create an Activation Key
notes:
- type: text
  contents: Activation Keys help you join systems to Satellite and assign repositories
tabs:
- title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- title: Satellite Server
  type: terminal
  hostname: satellite
difficulty: basic
timelimit: 1
---
<!-- markdownlint-disable MD033 -->

Activation keys provide a method to automate system registration and subscription attachment. You can create multiple keys and associate them with different environments and Content Views. For example, you might create a basic activation key and associate it with Content Views from a particular environment.

You can use activation keys during content host registration to improve the speed, simplicity and consistency of the process. Note that activation keys are used only when hosts are registered. If changes are made to an activation key, it is applicable only to hosts that are registered with the amended activation key in the future. The changes are not made to existing hosts.

Creating an Activation Key
==========================

1. Navigate to the Activation Keys menu by hovering over `Content` and clicking on `Activation Keys`.

1. Click `Create Activation Key` on the top right

1. Fill out the form with the following information
    Name:
    ```
    rhel-dev
    ```
    Environment:
    ```
    Development
    ```
    Content View:
    ```
    Everything
    ```

1. Click `Save`

1. Repeat this for `rhel-prod` but using the `Production` environment
