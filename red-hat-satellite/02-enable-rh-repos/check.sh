#!/bin/bash

enabled=$(hammer repository-set list --organization-id 1 --enabled true)

issues=0

# Check for RHEL 9 BaseOS Kickstart repo
if ! (echo $enabled | grep 'Red Hat Enterprise Linux 9 for x86_64 - BaseOS (Kickstart)')
then
  echo "A repo within \"Red Hat Enterprise Linux 9 for x86_64 - BaseOS (Kickstart)\" is not enabled"
  issues=$(($issues + 1))
fi

# Check for RHEL 9 AppStream Kickstart repo
if ! (echo $enabled | grep 'Red Hat Enterprise Linux 9 for x86_64 - AppStream (Kickstart)')
then
  echo "A repo within \"Red Hat Enterprise Linux 9 for x86_64 - AppStream (Kickstart)\" is not enabled"
  issues=$(($issues + 2))
fi

# Check for RHEL 9 BaseOS repo
if ! (echo $enabled | grep 'Red Hat Enterprise Linux 9 for x86_64 - BaseOS (RPMs)')
then
  echo "A repo within \"Red Hat Enterprise Linux 9 for x86_64 - BaseOS (RPMs)\" is not enabled"
  issues=$(($issues + 4))
fi

# Check for RHEL 9 AppStream repo
if ! (echo $enabled | grep 'Red Hat Enterprise Linux 9 for x86_64 - AppStream (RPMs)')
then
  echo "A repo within \"Red Hat Enterprise Linux 9 for x86_64 - AppStream (RPMs)\" is not enabled"
  issues=$(($issues + 8))
fi

# Check for Satellite Client for RHEL 9
if ! (echo $enabled | grep 'Red Hat Satellite Client 6 for RHEL 9 x86_64 (RPMs)')
then
  echo "A repo within \"Red Hat Satellite Client 6 for RHEL 9 x86_64 (RPMs)\" is not enabled"
  issues=$(($issues + 16))
fi


# Check download policy for BaseOS Kickstart repo
echo "The following kickstart repos are still have their download policy set to \"on demand\""
hammer --no-headers repository list --download-policy on_demand --search 'name ~ *Kickstart*' --fields name
if [[ $? == 0 ]]
then
  echo "None"
  issues=$(($issues + 32))
fi

return $issues