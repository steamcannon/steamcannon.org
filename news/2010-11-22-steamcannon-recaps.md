---
title: SteamCannon Recap for Nov 6 - 12
author: Ben Browning
layout: news
sequence: 1
---

Now that our community is growing, I'm starting the "SteamCannon
Recap." Its purpose is to ensure important discussions and questions
that take place outside the mailing list make their way to it for the
benefit of the entire community.

I wish I could say I came up with this idea, but I stole it from the
open-source project Riak.

Feedback is welcome.

Ben

________________

## SteamCannon Recap for Nov 6 - 12

1) We pushed an update to try.steamcannon.org with several bug fixes
and some new features, including the ability to reset your password
via email if you forget it. Full details here:  
<https://jira.jboss.org/secure/ReleaseNote.jspa?projectId=12311083&version=12315585>

2) One of our users pointed out that we didn't document the username
and password for logging in to the VMware appliance anywhere. The
credentials are root/boxgrinder and are now documented here:  
<http://steamcannon.org/documentation/getting_started/vmware_appliance/>

3) Work has started on supporting 64bit Amazon AMIs. There are lots of
small details to work out but we expect to support all 64bit instance
types in the next release.

4) miclark in #steamcannon asked about retrieving log and other files
off the instances booted by SteamCannon. Full conversation here:  
<https://gist.github.com/674913>
