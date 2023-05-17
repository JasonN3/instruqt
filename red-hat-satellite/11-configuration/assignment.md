---
slug: configuration
type: challenge
title: Configure groups of machine
teaser: Assign configurations to groups of machines.
tabs:
- title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- title: Satellite Server
  type: terminal
  hostname: satellite
- title: API Doc
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io/apidoc
difficulty: basic
timelimit: 0
---
<!-- markdownlint-disable MD033 MD029-->

Red Hat Satellite provides a couple of ways to manage configurations. The integrated Puppet does a great job at ensure machines stay at the desired state and reverting any configuration drift. There was a rumor that Puppet was being removed from Satellite, but that decision was reversed before it went in to affect. It will [continue as a plugin](https://www.redhat.com/en/blog/upcoming-changes-puppet-functionality-red-hat-satellite) and can still be [enabled in the current version of Satellite](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.13/html/managing_configurations_using_puppet_integration_in_red_hat_satellite/introducing-configuration-management-using-puppet_managing-configurations-puppet#Enabling_Puppet_Integration_managing-configurations-puppet). Syncing Puppet modules has been removed from Pulp, however, that functionality can be replaced and improved with R10k.

Some sample Puppet modules are provided in this lab. R10k is configured on the server to sync the modules in https://github.com/JasonN3/puppet_modules to the server. The configuration file is available at /etc/puppetlabs/r10k/r10k.conf on the server.

Import Environments
===================

Whenever a class is added/updated/removed, Satellite needs to be told so it can update the UI. This can also be accomplished using the API if you would like to make it part of your CI/CD pipeline or any other script. The documentation for the api is available on any Satellite server by going to https://satellite_server/apidoc. To see what it looks like, feel free to check out the `API Doc` tab.

The clients, however, will see the updates immediately when the new modules are synced to the server without any manual intervention.


1. Navigate to the Environments page by hovering over `Configure` and clicking on `Environments`. This can also be accomplished on the `Classes` page

1. Click `Import environments from satellite`

1. Click the checkbox next to `production` and click `Update`

Enable Smartclass Parameters
============================

Smartclass Parameters are the inputs to your classes. They will allow you to customize the class to your needs without having to make any changes to the code. They are assigned to machines using matchers. These matchers can target any attribute of the machines. This can include hostgroup, environment, location, domain, os, fqdn, any facts that are collection from the machine, etc. You also have the ability to merge the desired value from multiple matchers. This gives you a lot of flexibility to manage your systems in a way that's custom to you without having to write any code.

1. Navigate to the Classes page by hovering over `Configure` and clicking on `Classes`.

1. In this example, we'll set auto_update to true for Insight's client so click on `access_insights_client`.

1. Click on the `Smart Class Parameter` tab

1. Select the `auto update` parameter

1. Check `Override` so you have the ability to customize the value

1. Since the value is `undef` (undefined) by default and we aren't going to modify that, check `Omit` so the default value from the class will be used.

At this point you can see you have the option to set a default value, customize the order for the matchers, and create matchers. We're going to set the value somewhere else though. However, regardles of where you set the value, it will always be visible here as a matcher.

1. Click `Submit` to save what we have done so far.

Assign a Class to a Host Group
==============================

1. Navigate to the Host Groups page by hovering over `Configure` and clicking on `Host Groups`

1. Click on the `General` host group

1. Make sure the `Environment` is set to `production`. You do not need to click submit right now because we will be making other changes. All changes will get saved when we click submit later.

1. Click on the `Puppet ENC` tab

1. Expand the `access_insights_client` module by click on the name or the `+` sign next to it

1. Assign the `access_insights_client` to the host group by click on the name or the `+` sign next to it

1. You should now see the `auto_update` parameter in the list of `Puppet Class Parameters`. Click the edit button to change the value.

1. Set the value to `true` and click `Submit`

Now, any machine that is a part of the `General` host group or a child host group will automatically get the Insight's agent installed.

If you go back to the smart class parameter, you can see there is a new matcher that was automatically created. This is how Satellite stores all of the customized values

Test Your Knowledge
===================

All of Department1's servers will be web servers. Assign the class `demo_webserver` to their host group
