---
slug: jobs
type: challenge
title: Creating a job template
teaser: Job templates can be used to run commands on-demand or on a schedule
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

Job Templates allow you to create templated version of bash script or Ansible playbooks that can be run against a selection of machines. The templates are rendered individually for each machine which gives you a lot of flexibility. Just like the rest of the templates within Satellite, job templates are written as Ruby templates. However, a lot of variables are available as Ansible variables, so you don't have to use any Ruby in your template. For this step, we're not going to use any Ruby. We'll just write a Ansible playbook.


Create a Job Template
=====================

1. Navigate to the Job Templates page by hovering over `Hosts` and clicking on `Job Templates`.

1. Click on `New Job Template` at the top right

1. Name the template `Install patches`

1. Enter the following Ansible playbook in the editor
    ```yaml
    ---
    - name: Patch RHEL systems
      hosts: all
      tasks:
        - name: Ensure the machine is online
          ansible.builtin.wait_for_connection:

        - name: Install needs-restarting
          ansible.builtin.package:
            name: yum-utils
            state: present

        - name: Update all packages
          ansible.builtin.package:
            name: '*'
            state: latest

        - name: Check to see if we need a reboot
          when: reboot == 'auto'
          ansible.builtin.command: needs-restarting -r
          register: result
          ignore_errors: true

        - name: Reboot Server
          ansible.builtin.reboot:
          when: reboot == 'always' or result.rc == 1

        - name: Apply all assigned roles
          ansible.builtin.include_role:
            name: "{{ role }}"
          loop: "{{ foreman_ansible_roles }}"
          loop_control:
            loop_var: role
    ```
    This Ansible playbook will:
    1. Make sure the machine is online
    1. Ensure needs-restarting is available by installing yum-utils
    1. Update all installed packages
    1. Run needs-restarting to identify if a reboot is required
    1. Reboot the server if needs-restarting said it was needed or if the input `reboot` is set to always. This will also wait for the machine to come back up
    1. Run any Ansible roles that are assigned to the machine

1. Switch to the `Inputs` tab and click `Add Input`

1. Name the input `reboot`

1. Mark the input as required

1. Copy the following options in to `Options`
    ```
    auto
    always
    never
    ```

1. Set the default value to `auto`

1. Change to the `Job` tab

1. Leave the `Job Category` as `Miscellaneous`

1. Set the  `Provider Type` to `Ansible`

1. Click `Submit`

Running a Job Template
======================

1. Navigate to the Jobs page by hovering over `Monitor` and clicking `Jobs`

1. Click `Run Job` at the top right

1. Select `Miscellaneous` as the `Job category`

1. Select `Install patches` as the `Job template`

1. For the Search Query, type in some or all of the machine name you deployed earlier. Alternatively, you can specify `lifecycle_environment = dev` as it should be the only machine in the dev lifecycle environment

1. Set `reboot` to `always. Since we just deployed the system, there won't be any updates, but we still want the machine to reboot

1. Click `Submit`

You'll now be brought to the job status page. The job should run pretty quickly since there isn't much to do.

1. Click on the host in the bottom table.

This should bring you to the output of the individual run. This update will automatically update as the job run.

Once the job completes, you should see near the bottom that the httpd role resolved an issue it found. This was intentional. The Puppet class you assigned earlier was configured to install httpd and also disable the service. The web server seemed like it was healthy, but a reboot would result in it not starting. This is where Puppet and Ansible can complement each other. Puppet is a great configuration manager and Ansible is a great scripting language. As part of the script we just ran to patch the machine, we used Ansible to run a health check and try to resolve any issues. This was a simple example where we caused the problem, but it could be expanded to check any application and attempt various automated repairs. It also doesn't require the job template to know what was running on the machine. Instead, Ansible used to variable `foreman_ansible_roles` to find out what roles were assigned to the machine.

Outgrowing Satellite Alone
==========================

While the Ansible built-in to Satellite is powerful, as your Ansible usage expands, you'll likely want to do something that extends past what it can handle. There are some ways to force it to handle those processes, but it's normally a lot of work that someone else already did. This is where AAP comes in. It allows you to have more complex scripts. An example of this is expanding on the `Install patches` job we just created. If you were to design that one within AAP, you could have it pull the machine out of a load-balancer pool, take a snapshot of the VM, run the patches, do the health check/repair, and then delete the snapshot and add it back to the pool if everything passed or rollback and send out an alert if something failed.

Satellite can be used as an inventory source for AAP, so a lot of the organization and management you do in Satellite can be utilized within AAP.