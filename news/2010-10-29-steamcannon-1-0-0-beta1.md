---
title: SteamCannon 1.0.0.Beta1 Released
author: Ben Browning
layout: release
version: 1.0.0.Beta1
sequence: 2
official: true
---

We're proud to announce the first release of SteamCannon, 1.0.0.Beta1!
Grab the Amazon AMI, VMware appliance, or .zip bundle from our
[download](/download) page.

We're shipping three platforms in this release:

* **Developer Instance** containing JBoss AS and PostgreSQL on a single image
* **JBoss 2-Tier** containing a mod_cluster image and a JBoss AS image
* **JBoss 3-Tier** containing a mod_cluster image, a JBoss AS image, and a PostgreSQL image

The platforms are based on [JBoss AS 6 Milestone 5][as6m5],
[mod_cluster 1.1.0][mod_cluster], and [PostgreSQL 8.4.5][postgresql].

[as6m5]: http://community.jboss.org/wiki/AS600M5ReleaseNotes
[mod_cluster]: http://docs.jboss.org/mod_cluster/1.1.0/html/changelog.html
[postgresql]: http://www.postgresql.org/docs/8.4/static/release-8-4-5.html

This is a beta release of SteamCannon using the latest milestone
release of JBoss AS 6, so some applications might not deploy
properly. If you run into any issues, bring them up on our [mailing
lists](/community/mailing_lists/) or [IRC channel](/community/) and
we'll help you work through them.

If you'd like to see all the hard work that went into this release,
check out or [JIRA][jira] or [Git][git] logs.

[jira]: #{release_for_version(page.version).urls.jira}
[git]: #{release_for_version(page.version).urls.github.log}
