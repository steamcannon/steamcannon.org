---
layout: default
title: Concepts
sections:
  - Documentation
  - Overview
---

# What is SteamCannon?

SteamCannon is a JavaEE and Ruby Platform-as-a-Service (PaaS). It
provides a consistent platform for your applications regardless of the
underlying public or private cloud. Your applications are deployed on
[mod_cluster], [JBoss AS] w/ [TorqueBox], and [PostgreSQL] - with
unrestricted access to all APIs.

[mod_cluster]: http://www.jboss.org/mod_cluster
[jboss as]: http://www.jboss.org/jbossas/
[torquebox]: http://torquebox.org
[postgresql]: http://www.postgresql.org/

The user-facing portion of SteamCannon is a Rails application that can
be run locally or in the cloud. It's used to start, stop, and
configure the environments that applications are deployed to.


# Terminology

## Artifact

An artifact is a deployable file. Examples of valid Java artifacts
would be war files, ear files, jar files, and datasources. Valid Ruby
artifacts would be .rails archives, *-rack.yml deployment descriptors,
or any other type supported by TorqueBox.

## Service

A service is the smallest building block of a platform. SteamCannon
currently has three services - mod_cluster, JBoss AS, and PostgreSQL.

## Image

An image is a virtual machine that provides one or more
services. SteamCannon's images are created by [BoxGrinder] from the
[steamcannon-appliances] repository.

[boxgrinder]: http://www.jboss.org/boxgrinder
[steamcannon-appliances]: http://github.com/steamcannon/steamcannon-appliances/

## Platform

A platform is a predefined collection of 1 - N images shared by all users of SteamCannon.

## Environment

An environment is an instance of a platform and the thing that
artifacts are deployed into. A user can have many environments from
multiple platforms. For example, you might have a Development
environment based off of the developer platform and QA and Production
environments based off of the 3-Tier Platform.

## Instance

An instance represents a running image. One or more instances is
contained in every running environment. When an environment is started
a configurable number of instances is started for each image in the
environment's platform. When an environment is stopped, all running
instances in that environment are stopped.
