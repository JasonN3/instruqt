---
slug: deployment
type: challenge
title: Deploying a machines
teaser: Now we get to see the result of everything we've configured.
tabs:
- title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- title: Satellite Server
  type: terminal
  hostname: satellite
difficulty: basic
timelimit: 0
---
<!-- markdownlint-disable MD033 MD029-->

The Satellite already has a Compute Resource configured for you. This Compute Resource will give you the ability to create 1 VM in GCP


Create Host
============

1. Navigate to the Create Host page by hovering over `Hosts` and clicking on `Create Host`.

1. A name will be automatically generated for you, but feel free to change it to whatever you want

1. Select `General/Domain/Department1/Department1-dev` as the Host Group.

1. Give it a second to automatically populate the rest of the fields. You'll see a spinning circle at the top while it is collecting the information

1. The rest of the fields should now be populated, however, `Deploy On` is set to `Bare Metal` and we're going to have Satellite create the VM. Click on `inherit` to allow you to override the value.
    `Bare Metal` can be used for more than just bare-metal boxes. `Bare Metal` just tells Satellite that it won't be the one creating the VM. You can then use PXE or the boot disk to deploy anywhere. The boot disk can even be used in the cloud. Just download the ISO and convert it to the appropriate format. You can then use that as your source image.

1. Set `Deploy On` to `Instruqt Sandbox`.

1. Once you change `Deploy On`, a new field for `Compute profile` should appear as well as a `Virtual Machine` tab. Click `inherit` next to `Compute profile` so you can set that value as well.

1. Set `Compute profile` to `demo`. The compute profile will include all of the default values that are set in the `Virtual Machine` tab. Feel free to look at what settings were set.

1. Next, we'll tell Satellite what OS to install. Change to the `Operating System` tab.

1. Set Architecture to `x86_64`

1. Set `Operating system` to `RedHat 9.1`

1. Set `Provisioning Method` to `Image Based`

1. Set `Image` to `RHEL 9.1`

1. Set a root password. If you do not set one, a default one has been configured of `redhat123`

1. Change to the `Interfaces` tab

1. Edit the existing interface. Do NOT create a new interface

1. Set the domain to `${_SANDBOX_ID}.instruqt.io`

1. Set the subnet to the only subnet available

1. Click `Submit`

If everything was done right, the VM should being created. If you get an error, start over at step 1. There are some errors you can 