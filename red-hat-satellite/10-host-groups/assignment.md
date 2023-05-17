---
slug: host-groups
type: challenge
title: Configure Host Groups
teaser: Host groups are used to organize and configure sets of hosts.
tabs:
- title: Satellite Server
  type: terminal
  hostname: satellite
- title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
difficulty: basic
timelimit: 0
---
<!-- markdownlint-disable MD033 MD029-->

Satellite provides several logical units for grouping hosts. Hosts that are members of host groups inherit the group's configuration. It is recommended to configure the majority of settings at the host group level instead of defining hosts directly. Configuring a new host then largely becomes a matter of adding it to the right host group. As host groups can be nested, you can create a structure that best fits your requirements.

For more information on Host Groups, please see the [documentation](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.12/html/satellite_overview_concepts_and_deployment_considerations/chap-architecture_guide-host_grouping_concepts).

Below is the structure we will create for this lab:
```
- General
  - Domain
    - Department1
      - Department1-dev
      - Department1-prod
  - Non-Domain
```

- General is the top level group where you can assign any settings that should apply to all machines. There are other locations in Satellite where you can apply settings to all machines, but this brings it to a single location
- General/Domin is the group where you can define any settings that should apply to all domain joined systems
- General/Non-domain is for the systems you cannot join to the domain and have to sit separate. It is still recommended to create the "department" and "department-lifecycle" groups if you plan to use this group
- General/Domain/Department1 is for you to assign any settings that should apply to any machines within that department/group. For organization, feel free to create additional nested groups within this group
- General/Domain/Department1-dev exists to set the lifecycle step and make queries/bookmarks easier to work with. Settings shouldn't be applied at this level so you'll know your environments aren't too different, but all machines should be assigned to a group at this level. If that isn't clear, don't worry. We will deploy a machine later on.

Creating the Host Groups
========================

1. Navigate to the Host Groups menu by hovering over `Configure` and clicking on `Host Groups`.

1. Click `Create Host Group`

1. Fill out the form with the following information
    Name:
    ```
    General
    ```
    Lifecucle Environment
    ```
    Production
    ```
    Content View
    ```
    Everything
    ```
    Content Source:
    ```
    satellite.${_SANDBOX_ID}.instruqt.com
    ```
    Puppet Capsule:
    ```
    satellite.${_SANDBOX_ID}.instruqt.com
    ```
    Puppet CA Capsule:
    ```
    satellite.${_SANDBOX_ID}.instruqt.com
    ```
    OpenSCAP Capsule:
    ```
    satellite.${_SANDBOX_ID}.instruqt.com
    ```

1. Click  `Submit`

1. Click `Nest` at the far right on the row for the host group `General` to create a group that is nested within `General`

1. Enter the name `Domain` and click `Submit`. You do not need to enter anything else because those fields will inherit from the parent group.

Go ahead and repeat this process for the rest of the groups described above. When you get to the groups that end in `-dev` and `-prod`, make sure to set the `Lifecycle Environment` to `dev` and `prod` respectively and set the activation key on the `Activation Keys` tab to `rhel-dev` and `rhel-prod`.