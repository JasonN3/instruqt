---
slug: lifecycleenv
type: challenge
title: Manage Lifecycle Environments
teaser: Manage Lifecycle Environments
notes:
- type: text
  contents: Satellite provides methods to customize each application life cycle stage
    so that it suits your specifications. Each stage in the application life cycle
    is called an environment in Satellite.
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

Create a new lifecycle environment
==================================

The application life cycle is a concept central to Red Hat Satellite 6’s content management functions. The application life cycle defines how a particular system and its software look at a particular stage. For example, an application life cycle might be simple; you might only have a development stage and production stage. In this case the application life cycle might look like this:

- Development
- Production

However, a more complex application life cycle might have further stages, such as a phase for testing or a beta release. This adds extra stages to the application life cycle:

- Development
- Testing
- Beta Release
- Production

To find out more about lifecyce environments, please refer to [Satellite documentation](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.11/html/managing_content/creating_an_application_life_cycle_content-management.)

1. Navigate to the Lifecycle Environments page by hovering over `Content` and clicking on `Products`

    <img alt="Content -> Lifecycle Environments" src="../assets/content-lifecycle_environments.png" />

1. Click on `Create Environment Path`

    <img alt="Content -> Lifecycle Environments" src="../assets/lifecycle-create_path.png" />

1. Enter `Development` as the `Name` and click `Save`

1. Now we'll add `Production` to the end of the new environment path. Click on `Add New Environment`

    <img alt="Content -> Lifecycle Environments" src="../assets/lifecycle-add_environment.png" />

1. Enter `Production` as the `Name` and click `Save`.

    You'll notice that `Development` is listed as the `Prior Environment`. This will assist with helping you know the order of the lifecycle environments.