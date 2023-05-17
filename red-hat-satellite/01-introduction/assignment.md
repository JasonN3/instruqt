---
slug: introduction
type: challenge
title: Familiarize yourself with the Lab Environment.
teaser: This is an introduction to the lab environment.
notes:
- type: text
  contents: Familiarize yourself with the lab environment.
tabs:
- title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- title: Satellite Server
  type: terminal
  hostname: satellite
difficulty: basic
timelimit: 3420
---
Lab Environment
===============

The lab environment consists of the following:

- Red Hat Satellite 6.13 Server (Satellite is preinstalled)

Log into the Web UI
===================

First, we'll log into the Red Hat Satellite Web User Interface (UI). Satellite has been preinstalled and installation is out of scope for this lab.

Click on the tab labelled Satellite Web UI as shown in the image below.

 <img alt="Satellite Web UI tab" src="../assets/satellite-tab.png" />

You'll need the following credentials to log into the Satellite Web UI.

You can copy and paste each of them below.

```bash
admin
```

```bash
bc31c9a6-9ff0-11ec-9587-00155d1b0702
```

Now click `Log In`.

<img alt="Satellite Web Login page" src="../assets/weblogin-6.12.png" />

You will be taken to the main dashboard.  
Depending on if you log in with Mozilla Firefox or a Chrome-based browser, the order of widgets may be different.

<img alt="Satellite Dashboard" src="../assets/dashboard-6.12.png" />