---
layout: default
title: Technology
sections:
  - Documentation
  - Overview
---

# SteamCannon

SteamCannon consists of several components each with its own distinct technologies.

**Web Interface**

The user-facing portion of SteamCannon is built on top of [Torquebox],
[Rails], and [JRuby].

<http://github.com/steamcannon/steamcannon>

[torquebox]: http://torquebox.org
[rails]: http://rubyonrails.org
[jruby]: http://jruby.org

**Agent**

The agent runs on each instance launched by SteamCannon and is
responsible for configuring, deploying, and monitoring instances. It's
built on [Sinatra] and [Ruby].

<http://github.com/steamcannon/steamcannon-agent>

[sinatra]: http://www.sinatrarb.com
[ruby]: http://www.ruby-lang.org

**Images**

The SteamCannon appliance and the images for each platform are built by [BoxGrinder].

<http://github.com/steamcannon/steamcannon-appliances>

[boxgrinder]: http://www.jboss.org/boxgrinder

**steamcannon.org**

The steamcannon.org website is built using [Awestruct].

<http://github.com/steamcannon/steamcannon.org>

[awestruct]: http://awestruct.org/

# Platforms

SteamCannon's platforms are based on [JBoss AS 6 Milestone 5][as6m5],
[mod_cluster 1.1.0][mod_cluster], and [PostgreSQL 8.4.5][postgresql].

[as6m5]: http://community.jboss.org/wiki/AS600M5ReleaseNotes
[mod_cluster]: http://docs.jboss.org/mod_cluster/1.1.0/html/changelog.html
[postgresql]: http://www.postgresql.org/docs/8.4/static/release-8-4-5.html
