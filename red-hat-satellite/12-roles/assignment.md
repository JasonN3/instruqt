---
slug: roles
type: challenge
title: Assign roles to groups of machines
teaser: Assign roles to groups of machines.
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

In addition to assigning Puppet classes to machines, you can also assign Ansible roles. Ansible roles are more similar to scripts. Assigning them makes it easier to dynamically reference them during jobs.

Just like with Puppet modules, you will need to import them in to the Satellite server. This can also be accomplished using the API as well.

Import Roles
============

1. Navigate to the Roles page by hovering over `Configure` and clicking on `Roles`.

1. Click `Import from satellite`

1. Click the checkbox next to `httpd` and click `Update`

Assign a Role to a Host Group
=============================

1. Navigate to the Host Groups page by hovering over `Configure` and clicking on `Host Groups`

1. Click on the `Department1` host group

1. Click on the `Ansible Roles` tab

1. Assign the `httpd` role to the host group by click on the name or the `+` sign next to it

1. Click `Submit`
