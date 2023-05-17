---
slug: publishcontentview
type: challenge
title: Publish a content view
teaser: Publish a content view
notes:
- type: text
  contents: In this step, we'll publish the content view 
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
Publish the Content Views
=========================

Publishing take a snapshot of the repodata and makes sure that the machines attached to that version of the content view cannot see excluded packages or newer packages

1. Go back to the Content Views page by hovering over `Content` and clicking on `Content Views`

    <img alt="Content -> Content Views" src="../assets/content-content_views.png" />

1. Click on the `EPEL` content view and then click `Publish new version` at the top right

1. You can then immediately click `Next` and then `Finish`

    Since we will be assigning the composite content view to our machines, the individual component content views do not need to be promoted. They can be left at `Library`. Only the assigned content views need to be promoted.

    You can proceed to the next step while `EPEL` publishes. Even if you click `Close`, it will continue in the background

1. Go back to the Content Views menu by hovering over `Content` and clicking on `Content Views`

1. Click on the `RH Repos` content view and then click `Publish new version` at the top right

1. You can then immediately click `Next` and then `Finish`

1. Go back to the Content Views menu by hovering over `Content` and clicking on `Content Views`

1. Wait for both of the content views to finish publishing before continuing. If you try to continue before it is done, you will be missing packages in the composite content view

1. Click on the `Everything` composite content view and then click `Publish new version` at the top right

1. Enable `Promote` and make sure that `Development` is selected. Then click `Next` and then `Finish`

1. Wait for it to finish publishing before continuing

1. On the row for your new version of the content view, click the 3 dots all the way to the right. Then click `Promote`

1. Check `Production` and click `Promote`. This step could have been completed while publishing the new version, but normally you would promote the version to each lifecycle step when you are ready to patch the machines in the lifecycle step.

When a machine makes a request to Satellite, it will be returned the repodata for the content view version that has been promoted to the same lifecycle step that the machine is assigned to. For example, if you had the following configuration:

- `MachineA` is assigned to the `Development` lifecycle step
- `MachineB` is assigned to the `Production` lifecycle step
- Version `1.0` of the `Everything` Composite Content View (CCV) was promoted to the `Production` lifecycle step
- Version `2.0` of the `Everything` Composite Content View (CCV) was promoted to the `Development` lifecycle step

If `MachineA` goes to install a package, it will get the package version that is in version `2.0` of the `Everything` CCV. However, if `MachineB` goes to install the same package, it will get the package version that is in version `1.0` of the `Everything` CCV. `MachineB` will not be able to see the version available in version `2.0` until that version is promoted to `Production`. Also, since each version is a snapshot of the repodata, even if a newer version of the package is released, the neither machine will see it until a new version of the content views are created.

The recommended process for patching using the content views described in this lab is:

1. Publish a new version of the `RH Repos` and `EPEL` Content Views
1. Publish a new version of the `Everything` Composite Content View
1. Promote the new `Everything` Composite Content View (CCV) Version to `Development`
1. Patch all of the machines in the `Development` lifecycle environment
1. Promote the CCV Version to `Production`
1. Patch all of the machines in the `Prodcution` lifecycle environment

Since the same CCV version is be used for both lifecycle environments, all of the machines in `Production` would install the same package versions that `Development` installed regardless of whether new package version was release to the upstream repos.